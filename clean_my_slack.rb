#!/usr/bin/env ruby
# encoding: UTF-8

require 'net/http'
require 'json'
require 'uri'
require 'colorize'

# Get token at https://api.slack.com/web#authentication
@token = ARGV[2]
how_long_ago = (Time.now - ARGV[0].to_i * 24 * 60 * 60).to_i
params = {
    token: @token,          # Your Token
    ts_from: 0,             # From (timestamp)
    ts_to: how_long_ago,    # To (timestamp)
    types: 'all',           # File Types
    count: 1000,            # Items per page
    page: ARGV[1]           # Page
}

# List the files!
def list_files(params)
    parsed_response = parse_call('https://slack.com/api/files.list', params)
    parsed_response['files']
end

# Delete the files!
def delete_files(file_ids)
    file_ids.each do |file_id|
        params = {
            token: @token,
            file: file_id
        }
        delete_response = parse_call('https://slack.com/api/files.delete', params)
        puts "#{file_id}: #{delete_response['ok']}".green
    end
end

# Parse and call URI
def parse_call(url, params)
    uri = URI.parse(url)
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
end

puts "Getting files and ids...".yellow

files       = list_files(params)
file_ids    = files.map { |f| f['id'] }

puts "#{files.count} files found!".yellow
puts "Deleting #{files.count} files...".green

delete_files(file_ids)

puts "Done!"