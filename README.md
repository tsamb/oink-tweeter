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

## Setting up Sinatra
We will be working with a single Ruby file for this application. It will be an extension of the set up that Sinatra suggests on the "Getting Started" section of its [readme](http://www.sinatrarb.com/intro.html).

In the folder where you create your application Ruby file, create two more folders called "public" and "views". We will use the views folder to store a basic HTML page and the public folder to store our CSS file to style our HTML. The name of these folders is important: Sinatra expects these folder names by default for its web pages (views) and static files like CSS.

## Running the server

After setting up your "Hello world" in your ruby file, you can start your server by typing `ruby appname.rb`. You should see the words "Hello world" printed out when you visit the domain at `localhost:4567` in your browser. Congratulations! You're running a web server!

You can stop your server by pressing `ctrl-c` in your terminal. If you run your server with the `ruby appname.rb` command, you'll need to stop and restart your server anytime you make changes to your code.

If you want to be able to automatically reload code without stopping and starting your server, you can `gem install shotgun` and then run `shotgun appname.rb` instead. Shotgun will use your newly coded code anytime you make a web request, so you don't have to kill the server and restart it.

## Setting up to interact with Twitter
You'll need three things before you can use the Twitter API with your app:
  1. The Twitter gem
  2. "Consumer keys" to authorize your app
  3. "Access tokens" to authorize you as a Twitter user

### Installing and requiring the Twitter gem
`gem install twitter` in your terminal to install the Twitter gem. Right under `require sinatra` in your app, also `require twitter`. This will give you access the the [Twitter gem](http://rdoc.info/gems/twitter) (and hence, the Twitter API) in your code.

### Generating Twitter keys and tokens

Go to [apps.twitter.com](apps.twitter.com) and sign in. Click on "Create New App" in the top right hand corner. Give your app a name, description and website (you can put a link to your Twitter account in here). Read and agree to the developer rules and click "Create your Twitter application".

Click on the "Keys and Access Tokens" tab. Vlick on "modify app permissions" next to "Access Level", change this to "Read and Write" and save the settings.

Go back to the "Keys and Access Tokens" tab, scroll to the bottom and click "Create my access token". The access token and secret are linked to your own personal Twitter account. Do not let these get out into the public, otherwise people may be able to hijack your account and tweet through your app as if they were you. If you accidentally push code containing these keys to a public location, ensure you revoke token access (on this same page) or regenerate the tokens. The same privacy rules apply for your consumer secret (for your app).


