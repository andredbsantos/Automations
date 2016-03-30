# Life Automations [![Codacy Badge](https://api.codacy.com/project/badge/grade/8fe531631b424c1b876c2bf6c06b90b8)](https://www.codacy.com/app/wildlifechorus/Automations)

```sh
wp_security_check.rb
Automates WPScan to send you a Wordpress security scan report to your email.
You just need to add this file to your WPScan folder.

clean_my_slack.rb
Cleans the files you uploaded to Slack to avoid getting to the file limit.

sms_with_slack.rb
Slack bot that uses Twilio to send an SMS to a given phone number.

screw_you_pingdom.rb
Checks if server is online, if not, sends you an email (marks as Urgent) and sends you an SMS using Twilio.

dont_send_me_passwords.rb
Checks if you got someone stupid in your company sending you emails asking for passwords in plain text.
```

## Usage

```sh
ruby wp_security_check.rb http://your-wordpress-site.com
ruby clean_my_slack.rb DAYS_AGO PAGE SLACK_TOKEN
ruby sms_with_slack.rb
ruby screw_you_pingdom.rb 127.0.0.1
ruby dont_send_me_passwords.rb
```

Install the following gems:
```dotenv twilio-ruby gmail net/ping slack-ruby-client phonelib json uri net/http```

## Crons

```sh
# Runs `wp_security_check.rb` every day.
0 0 * * * /path/to/automations/wp_security_check.rb http://your-wordpress-site.com >> /path/to/automations/logs/wp_security_check.log >/dev/null 2>&1

# Runs `screw_you_pingdom.rb` every 5 minutes.
*/5 * * * * /path/to/automations/screw_you_pingdom.rb 127.0.0.1 >> /path/to/automations/logs/screw_you_pingdom.log 2>&1

# Runs `dont_send_me_passwords.rb` every 30 minutes.
*/30 * * * * /path/to/automations/dont_send_me_passwords.rb >> /path/to/automations/logs/dont_send_me_passwords.log 2>&1
```

## Changelog

```sh
2016-03-30 - Added wp_security_check.rb
2016-02-08 - Added clean_my_slack.rb
2016-01-05 - Added sms_with_slack.rb
2015-12-31 - Added dont_send_me_passwords.rb
2015-12-30 - Added logs and cron job to screw_you_pingdom.rb
2015-12-29 - Added screw_you_pingdom.rb
```

## TODO

```sh
1 - Auto happy birthday on Facebook.
2 - Get DB dump from production and import DB on you local env.
```
