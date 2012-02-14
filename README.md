iPhone SMS viewer
=================

Uses Ruby/Sinatra to serve up an archived conversation from an iPhone sms.db sqlite file.

Installation
------------

1. `bundle install`
2. Copy your sms.db file to the _db_ directory (see
[here](http://joshuawood.net/backup-sms-db-on-ios-iphone4/) for instructions)
3. `ADDRESS=[phone number] ruby server.rb`

If using pow, create a _.powrc_ file to handle the environment:
`echo 'export ADDRESS=[phone number]' > .powrc`, and then link the directory to
`~/.pow` like normal. Site should then be available at _http://valentine.dev_