require 'open-uri'
require 'nokogiri'

xml = Nokogiri::XML(open(ARGV[0]))
xml.xpath('//file').each do |file|
  if file['source'] == 'original' && file['name'] =~ /\.mp4/
    filename = File.basename(file['name'], '.*')
    file_url = File.join(File.dirname(ARGV[0]), file['name'])
    output_filename = "#{filename}.mp3"
    puts %Q(curl -s "#{file_url}" | ffmpeg -i pipe:0 -b:a 192K -vn "#{output_filename}" && ffmpeg-normalize "#{output_filename}" -o "#{output_filename}" -f)
  end
end
