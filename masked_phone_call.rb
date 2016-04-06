#!/usr/bin/env ruby
# encoding: UTF-8

require 'twilio-ruby'

# TWILIO Stuff
MY_NUMBER           = '+000123456789'
TWILIO_ACCOUNT_SID  = "TWILIO_ACCOUNT_SID"
TWILIO_AUTH_TOKEN   = "TWILIO_AUTH_TOKEN"
@twilio             = Twilio::REST::Client.new TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN

# get main account
@account = @twilio.accounts.get(TWILIO_ACCOUNT_SID)

# get number list
@numbers = @account.incoming_phone_numbers.list

# check if you have any numbers, get the first one and makes the masked call
if @numbers.any?
    puts "We'll be using #{@numbers[0].phone_number} as a masked number..."
    puts "To connect YOU (#{MY_NUMBER}) to #{ARGV[0]}..."
    puts "Connecting..."
    @twilio.account.calls.create(
        :from   => @numbers[0].phone_number,
        :to     => ARGV[0],
        :url    => 'http://twimlets.com/forward?PhoneNumber=' + MY_NUMBER
    )
else
    puts "You must purchase a number first!"
end
