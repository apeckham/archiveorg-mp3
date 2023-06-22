require 'open-uri'
require 'nokogiri'

xml = Nokogiri::XML(open(ARGV[0]))
xml.xpath('//file').each do |file|
  if file['source'] == 'original'
    filename = File.basename(file['name'], '.*')
    file_url = File.join(File.dirname(ARGV[0]), file['name'])
    output_filename = "#{filename}.mp3"
    command = %Q(curl -s "#{file_url}" | ffmpeg -i pipe:0 -b:a 192K -vn "#{output_filename}" && ffmpeg-normalize "#{output_filename}" -o "#{output_filename}" -f)
    system(command) || raise("An error occurred while executing the command: #{command}")
  end
end
