#!/usr/bin/env ruby
# encoding: UTF-8

require 'dotenv'
require 'gmail'

Dotenv.load

# Gmail Stuff
EMAIL 		        = "your_email@host.com"
PASSWORD 	        = "you_password"
CHECKER 	        = Gmail.connect(EMAIL, PASSWORD)

# Other important constants
PASSWORDS_REGEX 	= /password|pass|pwd/i
COMPANY_HOST 		= "company.com"

# Logger
def log_this(msg)
  puts "#{Time.now}: #{msg}"
end

# Reply to someone who is kinda stupid
def create_reply(subject, stupid)
  CHECKER.compose do
    to          stupid
    subject     "RE: #{subject}"
    body        "I really hope you're not sending/asking me passwords\nSpecially in plain text...\n\nIf so...come talk to me in person!"
  end
end

# Check for stupid people sending me passwords in plain text
CHECKER.inbox.find(:unread).each do |email|
  if email.body.raw_source[PASSWORDS_REGEX] && email.from[0]['host'] == COMPANY_HOST

    # Get stupid email
    stupid_email	= email.from[0]['mailbox'] + "@" + email.from[0]['host']

    # Log stupidity
    log_this("#{email.from[0]['name']} - (#{stupid_email}) was stupid enough to talk about passwords using email...")

    # Mark as read, label the stupidity
    email.read!
    email.label('Stupid Stuff')

    # Serve them with a fresh plate of wisdom
    reply = create_reply(email.subject,stupid_email)
    CHECKER.deliver(reply)
  end
end
