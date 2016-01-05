#!/usr/bin/env ruby

require "twilio-ruby"
require "slack-ruby-client"
require "phonelib"

# Slack Stuff
SLACK_TOKEN         = "xoxb-177606212122421-Cf0qz5Az0gn4xBoBhnLZRsqM"

Slack.configure do |config|
config.token        = SLACK_TOKEN
end

# Twilio Stuff
TWILIO_NUMBER		= "+15005550006"
TWILIO_ACCOUNT_SID	= "AC712b324e706b43931df20c86728f3ddc5"
TWILIO_AUTH_TOKEN	= "f4884f79955a2dd4bea48994964404a8a"
@twilio             = Twilio::REST::Client.new TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN

# Init Slack Client
SLACK_CLIENT = Slack::RealTime::Client.new
SLACK_CLIENT.on :hello do
    log_this("Connected! Start sending SMS from " + TWILIO_NUMBER + "!")
end

# Logger
def log_this(msg)
    puts "#{Time.now}: #{msg.tr('*', '')}"
end

# SMS Method!
def sms(number, message)
    @twilio.messages.create(
        from:   TWILIO_NUMBER, 
        to:     number, 
        body:   message
    )
    log_this("SMS sent to #{number} - #{message}")
end

# Message on Slack
def msgSlack(channel, message)
    SLACK_CLIENT.message channel: channel, text: message
end

# Watch messages on Slack and react!
SLACK_CLIENT.on :message do |data|
    
    # Take care of data
    content			= data['text'].split(" ", 3)
    number			= content[1].nil? ? false : content[1]
    message			= content[2].nil? ? false : content.last
    
    # Commands
    case content.first
        when "SMS" then 
            unless Phonelib.valid?(number) and message
                msgSlack(data['channel'], "*Something went wrong, check the number and message...*")
                log_this("Error sending message (#{message}) to #{number} from #{data['user']}!")
            else
                sms(number, message)
                msgSlack(data['channel'], "*Message sent to #{number} - #{message}*")			
                log_this("Message (#{message}) sent to #{number} from #{data['user']}!")
            end
        when "HELP" then
            msgSlack(data['channel'], "*Usage: SMS +351917723456 Message you want to send*")
        when /^bot/ then
            msgSlack(data['channel'], "*What?, type 'HELP'!*")
    end
end

SLACK_CLIENT.start!
