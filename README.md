# Life Automations

```sh
clean-my-slack.rb
Cleans the files you uploaded to Slack to avoid getting to the file limit.

sms-with-slack.rb
Slack bot that uses Twilio to send an SMS to a given phone number.

screw-you-pingdom.rb
Checks if server is online, if not, sends you an email (marks as Urgent) and sends you an SMS using Twilio.

dont-send-me-passwords.rb
Checks if you got someone stupid in your company sending you emails asking for passwords in plain text.
```

## Usage

```sh
ruby clean-my-slack.rb DAYS_AGO PAGE SLACK_TOKEN
ruby sms-with-slack.rb
ruby screw-you-pingdom.rb 127.0.0.1
ruby dont-send-me-passwords.rb
```

Install the following gems: ```gem install dotenv twilio-ruby gmail net/ping slack-ruby-client phonelib json uri net/http```

## Crons

```sh
# Runs `screw-you-pingdom.rb` every 5 minutes.
*/5 * * * * /path/to/automations/screw-you-pingdom.rb 127.0.0.1 >> /path/to/automations/logs/screw-you-pingdom.log 2>&1

# Runs `dont-send-me-passwords.rb` every 30 minutes.
*/30 * * * * /path/to/automations/dont-send-me-passwords.rb >> /path/to/automations/logs/dont-send-me-passwords.log 2>&1
```

## Changelog

```sh
2016-02-08 - Added clean-my-slack.rb
2016-01-05 - Added sms-with-slack.rb
2015-12-31 - Added dont-send-me-passwords.rb
2015-12-30 - Added logs and cron job to screw-you-pingdom.rb
2015-12-29 - Added screw-you-pingdom.rb
```

## TODO

```sh
1 - Auto happy birthday on Facebook.
2 - Get DB dump from production and import DB on you local env.
```