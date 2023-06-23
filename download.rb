require 'open-uri'
require 'nokogiri'

Nokogiri::XML(open(ARGV[0])).xpath('//file').each do |node|
  if node['source'] == 'original' && node['name'] =~ /\.mp4/
    file.puts File.join(File.dirname(ARGV[0]), node['name'])
  end
end
