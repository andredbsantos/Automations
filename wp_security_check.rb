#!/usr/bin/env ruby
# encoding: UTF-8

require 'dotenv'
require 'gmail'
require 'date'

Dotenv.load

# Args & Others
SITE                = ARGV[0]
REPORT              = 'report.log'

# Gmail Stuff
EMAIL               = "your_email@gmail.com"
PASSWORD            = "your_password"
SENDER              = Gmail.connect(EMAIL, PASSWORD)

# Threads (Update && Scan)
update_wpscan = Thread.new do
    system('ruby wpscan.rb --update >/dev/null 2>&1')
end

scan_wp = Thread.new do
    system('ruby wpscan.rb --url ' + SITE + ' --random-agent --follow-redirection --verbose --force --enumerate u > ' + REPORT)
end

# Functions
def update_and_scan(update, scan)
    puts "Updating WPScan Database..."
    update.join
    puts "-- Update complete!"

    puts "Scan started..."
    scan.join
    puts "-- Scan complete!"
end

def send_results(site, datetime, report)
    return unless File.file?(report)
    puts "Sending report to #{EMAIL}..."
    SENDER.deliver do
        to          'email_to_send_to@gmail.com'
        subject     "WPScan finished for site #{site} - #{datetime}"
        body        File.read(report)
    end
    puts "-- Report sent!"
    puts "Deleting report file..."
    File.delete(report)
    puts "-- Report deleted!"
end

# Runner!
update_and_scan(update_wpscan, scan_wp)
send_results(SITE, Time.now.strftime("%d/%m/%Y %H:%M"), REPORT)
puts "-----------------------"
puts "#{Time.now.strftime("%d/%m/%Y %H:%M")} - Done!"
puts "-----------------------"