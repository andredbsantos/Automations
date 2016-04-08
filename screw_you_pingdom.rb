#!/usr/bin/env ruby
# encoding: UTF-8

require 'net/ping'
require 'dotenv'
require 'gmail'
require 'twilio-ruby'
require 'colorize'

Dotenv.load

# Gmail Vars
SENDER_EMAIL        = "servermonitor@gmail.com"
SENDER_PASSWORD     = "iadqegriqcggasng"
EMERGENCY_EMAIL     = "youemail@gmail.com"
EMERGENCY_PASSWORD  = "jzmbewodtodvqbvc"
Sender              = Gmail.connect(SENDER_EMAIL, SENDER_PASSWORD)
Emergency           = Gmail.connect(EMERGENCY_EMAIL, EMERGENCY_PASSWORD)

# TWILIO Stuff
TWILIO_NUMBER       = "+15005550006"
MY_NUMBER           = "+351916789754"
TWILIO_ACCOUNT_SID  = "AC712b324e706b43931df20c86728f3ddc5"
TWILIO_AUTH_TOKEN   = "f4884f79955a2dd4bea48994964404a8a"
@twilio             = Twilio::REST::Client.new TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN

# Server Stuff
SERVER_IP           = ARGV[0]

# Error Settings
error_msg           = "Check server (#{SERVER_IP})! Shit just hit the fan!"
error_subject       = "URGENT! #{SERVER_IP} is down!"

# Are you there?
def ping_it
    return true unless Net::Ping::External.new(SERVER_IP).ping
    log_this("Unable to ping #{SERVER_IP}", 'red')
end

# Email me!
def email_me(error_subject, error_msg)
    Sender.deliver do
        to      EMERGENCY_EMAIL
        subject error_subject
        body    error_msg
    end
    log_this("Email sent to #{EMERGENCY_EMAIL}", 'green')
end

# Mark the sent email as Urgent!
def mark_urgent
    Emergency.inbox.find(:unread, from: SENDER_EMAIL).each do |email|
        email.label("Urgent")
    end
    log_this("Email marked as Urgent on #{EMERGENCY_EMAIL}", 'yellow')
end

# Well...better get on the terminal right? SMS Me!
def sms_me(error_subject)
    @twilio.messages.create(
        from:   TWILIO_NUMBER,
        to:     MY_NUMBER,
        body:   error_subject
    )
    log_this("SMS sent to #{MY_NUMBER}", 'green')
end

# Runner!
def run(error_subject, error_msg)
    return unless ping_it
    email_me(error_subject, error_msg)
    sleep(2)
    mark_urgent
    sms_me(error_subject)
end

# Logger
def log_this(msg, color)
    puts "#{Time.now}: #{msg}".color
end

# Run this!
run(error_subject, error_msg)