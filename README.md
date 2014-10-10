oink-tweeter
============

# Overview
A pig latin tweeter in a simple Sinatra framework using the Twitter gem.

`gem install sinatra`
`gem install twitter`

You will need to set up a Twitter app at apps.twitter.com and export the hashes within your shell terminal:

```
export TWITTER_CONSUMER_KEY=yourconsumerkeyhere
export TWITTER_CONUMER_SECRET=yourconsumersecrethere
export TWITTER_ACCESS_TOKEN=yourtwitteraccesstokenhere
export TWITTER_ACCESS_TOKEN_SECRET=yourtwitteraccesstokensecrethere
```

Once you have your Twitter keys loaded, you can simply run the app by typing `ruby oink-tweeter`.

# How to build this app from scratch

## Environment set up
The following instructions assume that you have Ruby set up on the machine you are using. If you are using Mac OSX, you already have a system version of Ruby. Even if this is the case, I recommend installing [homebrew](http://brew.sh/#install) and then [rbenv](https://github.com/sstephenson/rbenv#homebrew-on-mac-os-x) to make sure that you are using Ruby from a location that doesn't require administrator privileges.
