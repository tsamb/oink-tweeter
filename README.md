oink-tweeter
============

# Overview / running this app as it is
This is a pig latin tweeter made with the [Sinatra](http://www.sinatrarb.com/) web framework using the [Twitter API](https://dev.twitter.com/rest/public).

You'll need the Sinatra gem and the Twitter gem:

`gem install sinatra`
`gem install twitter`

You will need to set up a Twitter app at apps.twitter.com and export the keys/tokens within your shell terminal:

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

If you want to be able to automatically reload code without stopping and starting your server, you can `gem install shotgun` and then run `shotgun appname.rb` instead. Shotgun will use your newly coded code anytime you make a web request, so you don't have to kill the server and restart it. (Note the default port for shotgun is 9393 so your site will be at `localhost:9393`.)

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

## Integrating the Twitter API into your app
The [Twitter gem docs](http://rdoc.info/gems/twitter) have good instructions on how to set up and use the Twitter API in Ruby. We will be utilizing the REST API in this app. The [configuration](http://rdoc.info/gems/twitter#Configuration0) and [usage example](http://rdoc.info/gems/twitter#Usage_Examples) on the home page of the gem docs. For a deeper dive into the methods on the REST module of the gem, check out [that section of the docs](http://rdoc.info/gems/twitter/Twitter/REST/Client).

Put the following code above your first route in your app:

```ruby
CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = "YOUR_CONSUMER_KEY"
  config.consumer_secret     = "YOUR_CONSUMER_SECRET"
  config.access_token        = "YOUR_ACCESS_TOKEN"
  config.access_token_secret = "YOUR_ACCESS_SECRET"
end
```

Replace the keys, tokens and secrets with those that you just generated at [apps.twitter.com](apps.twitter.com).

Note that we defined the `CLIENT` in all caps as a constant. Unlike a local variable (that would be defined lowercase like `client`), this constant is accessible inside the routes we write. We will be using `CLIENT` to interact with the API, including retrieving tweets and updating tweets.

### Returning Twitter data to your view
To begin, we'll plonk a string of data from Twitter onto your web page in place of "Hello world". We'll then refactor that out into an embedded Ruby HTML file and serve the HTML page to the browser.

Change your root route to:

```ruby
get '/' do
  # get an array of the latest 20 tweets from your personal timeline
  tweets = CLIENT.user_timeline

  # change every tweet object in the array into a string and join all the
  # strings together
  long_tweet_string = tweets.map { |tweet| tweet.text }.join("<br><br>")
end
```

Make sure your server is running with `shotgun` or `ruby` and navigate to your site in your browser. The get method above should return a string of your latest 20 tweets, separated by double `<br>` tags.

### Sending real HTML to the browser with ERB
Now that we know that we can get tweets and send them to our own front end, let's format it properly in HTML (as opposed to a string with some `<br>` tags). Change your root route to:
```ruby
get '/' do
  @tweets = CLIENT.user_timeline
  erb :index
end
```

We put an `@` in front of `tweets` to designate that variable as an instance variable. The reason we are doing this is to make it available to the `erb` method we call on the next line. As you will soon see, we will be able to access whatever we have stored in `@tweets` in the Embedded Ruby file we are about to create.

In your views folder, create a file called `index.erb`. In that file, create a stock-standard HTML layout:

```html
<!DOCTYPE html>
<html>
<head>
  <title>Oink Tweeter</title>
</head>
<body>

</body>
</html>
```

Because this is an ERB file, we can embed Ruby code in here and interpolate that into valid HTML and strings. Within your body tags, let's loop through our `@tweets` array and output the text of each tweet in a separate paragraph. It will look something like this:

```erb
<body>
  <% @tweets.each do |tweet| %>
    <p>
      <%= tweet.text %>
    </p>
  <% end %>
</body>
```

Here, we're looping through each tweet, creating a new `<p>` tag and interpolating the text from each tweet in here. You could play around with the [other methods on tweet objects](http://www.rubydoc.info/gems/twitter/Twitter/Tweet) here. For example, you could provide a link to the original tweet, by interpolating the `tweet.uri` into an `<a>` tag.

So the full flow of our app as it stands is:

  1. A user visits our root path
  2. The user's browser sends a request to our server
  3. Our server uses the Twitter keys it has stored to connect to Twitter and grab the latest 20 tweets in an instance variable
  4. Our route calls the `erb` method and sends our instance variable to our `index.erb` page.
  5. The `erb` method parses through the HTML document and inserts the text of each tweet into a paragraph tag.
  6. Our server sends the return value of that ERB parsed HTML file back to the browser.
  7. The user sees the latest 20 tweets on the page.

### Translating from English to Pig Latin

Currently, we're essentially replicating our own Twitter profile. Let's mix it up a bit and translate our tweets into pig latin before we send them down to the browser.

We need to write a method that takes a tweet (a string) and outputs a modified version of that string, pig-latinized. This is a nice little challenge to undertake if you know (or want to learn) a bit of Ruby.

We're going to adhere to the following pig latin rules:

1. For words that start with consonants, move all of the consonants to the end of the word and add "ay";
2. For words that start with vowels, simply add "way" to the end of the word.

So, for example:  
* "an awesome pig latin translator"  
becomes  
* "anway awesomeway igpay atinlay anslatorway"  

I implemented this logic in Ruby using regular expressions. These are powerful pattern matching tools that have a long history ([back to 1956!](https://en.wikipedia.org/wiki/Regular_expression#History)) and are implemented across many languages including Ruby. You could write your own pig latin translator using Ruby's string or array manipulation methods, too.

Let's walk through my translator, method by method:

```ruby
def substitution_rule_chooser(word)
  starts_with_vowel?(word) ? vowel_rule(word) : consonant_rule(word)
end
```
Here, we define a method that takes a word as an argument. Then whether or not that word starts with a vowel, one of two other methods will be run: applying the vowel rule, or applying the consonant rule.

```ruby
def starts_with_vowel?(word)
  word[0] =~ /[AEIOUaeiou]/
end
```
This method determines whether or not the first letter of a word is a vowel. `word[0]` is the first character of the argument we pass in. If that character matches our regular expression, any of the characters within the square brackets, then it will return a truthy value, otherwise it will return nil, which is falsey. [Here's the Ruby Docs entry for the matcher operator.](http://www.ruby-doc.org/core-2.2.0/String.html#method-i-3D-7E)

```ruby
def vowel_rule(word)
  word.sub(/(\w+)/, '\1way')
end
```
This method substitutes the whole word, for the whole word with "way" appended. [Here's the Ruby Docs entry for #sub](http://www.ruby-doc.org/core-2.2.0/String.html#method-i-sub), if you want to read more.

```ruby
def consonant_rule(word)
  word.sub(/(\A[^AEIOUaeiou_\W\d]+)(\w+)/, '\2\1ay')
end
```
Finally, here's the method to move the consonants to the end and tack on an "ay". This ones a little trickier than the vowel rule. Let's break down the regular expression a bit. Forward slashes encapsulate our regular expressions. So the actual regular expression here is `(\A[^AEIOUaeiou_\W\d]+)(\w+)`. We put the parentheses around two parts of this regular expression since we want to grab whatever is matched within those parts and save them to use later.

Within the first parentheses, the `\A` represents the start of the string. It says, "hey, whatever I tell you to match, make sure it starts at the start". The square brackets with the carrot `[^]` says to match anything **other** than the characters within these square brackets. In our case, we are saying match anything other than upper or lower case vowels or underscores. The `\W` and `\d` matchers represent non-word characters and numerals respectively. Finally, the `+` outside the square brackets says "give me one or more of these things". So ultimately our first match within the parentheses says "give me all of the non-vowel, non-numeric characters that are at the start of this string".

Within the second set of parentheses, the `\w` matcher simply asks for any word character (basically anything other than a symbol). Combine that with a plus and we are simply saying "give me the rest of the letters in this string".

Now that we have those two parts of our word captured, we can substitute them in reverse order. The `\1` in the second argument of our #sub method represents the first match, our consonants, and the `\2` represents the second match, the rest of our word. So, we replace our entire word with `\2\1ay`.

### Translating tweets before we send them to the browser  

Now we need to use our translation methods to pig latinize our tweet timeline before we send it to the browser.
