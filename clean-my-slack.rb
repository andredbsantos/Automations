#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'uri'

# Get token at https://api.slack.com/web#authentication
@token = ARGV[2]

# List the files!
def list_them_files
    how_long_ago = (Time.now - ARGV[0].to_i * 24 * 60 * 60).to_i
    params = {
        token: @token,          # Your Token
        ts_from: 0,             # From (timestamp)
        ts_to: how_long_ago,    # To (timestamp)
        types: 'all',           # File Types
        count: 1000,            # Items per page
        page: ARGV[1]           # Page
    }
    uri = URI.parse('https://slack.com/api/files.list')
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)['files']
end

# Delete the files!
def delete_them_files(file_ids)
    file_ids.each do |file_id|
        params = {
            token: @token,
            file: file_id
        }
        uri = URI.parse('https://slack.com/api/files.delete')
        uri.query = URI.encode_www_form(params)
        response = Net::HTTP.get_response(uri)
        puts "#{file_id}: #{JSON.parse(response.body)['ok']}"
    end
end

puts "Getting files and ids..."

files       = list_them_files
file_ids    = files.map { |f| f['id'] }

puts "#{files.count} files found!"
puts "Deleting #{files.count} files..."

delete_them_files(file_ids)

puts "Done!"