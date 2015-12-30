# Life Automations

screw-you-pingdom.rb => Check if server is online, if not, sends you an email (marks as Urgent) and sends you an SMS.

## Usage

```sh
ruby screw-you-pingdom.rb 127.0.0.1
```

Install the following gems: ```gem install dotenv twilio-ruby gmail net/ping```

## Crons

```sh
# Runs `screw-you-pingdom.rb` every 5 minutes.
*/5 * * * * /path/to/automations/screw-you-pingdom.rb >> /path/to/automations/logs/screw-you-pingdom.log 2>&1
```

## Changelog

```sh
2015-12-29 - Added screw-you-pingdom.rb
2015-12-30 - Added logs and cron job to screw-you-pingdom.rb
```