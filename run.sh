#!/usr/bin/env sh

set -ex

ruby -r open-uri -r nokogiri -e "puts Nokogiri::XML(URI.open(ARGV[0])).xpath('//file').select {|node| node['source'] == 'original' && node['name'] =~ /\.mp4/}.map {|node| File.join(File.dirname(ARGV[0]), node['name'])}" "$@" > urls.txt

aria2c -i urls.txt --on-download-complete=./postprocess.sh
