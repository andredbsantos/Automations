# Life Automations

```sh
screw-you-pingdom.rb
Checks if server is online, if not, sends you an email (marks as Urgent) and sends you an SMS.

dont-send-me-passwords.rb
Checks if you got someone stupid in your company sending you emails asking for passwords in plain text.
```

## Usage

```sh
ruby screw-you-pingdom.rb 127.0.0.1
ruby dont-send-me-passwords.rb
```

Install the following gems: ```gem install dotenv twilio-ruby gmail net/ping```

## Crons

```sh
# Runs `screw-you-pingdom.rb` every 5 minutes.
*/5 * * * * /path/to/automations/screw-you-pingdom.rb 127.0.0.1 >> /path/to/automations/logs/screw-you-pingdom.log 2>&1

# Runs `dont-send-me-passwords.rb` every 30 minutes.
*/30 * * * * /path/to/automations/dont-send-me-passwords.rb >> /path/to/automations/logs/dont-send-me-passwords.log 2>&1
```

## Changelog

```sh
2015-12-29 - Added screw-you-pingdom.rb
2015-12-30 - Added logs and cron job to screw-you-pingdom.rb
2015-12-31 - Added dont-send-me-passwords.rb
```

## TODO

```sh
1 - Auto happy birthday on Facebook.
2 - Get DB dump from production and import DB on you local env.
```