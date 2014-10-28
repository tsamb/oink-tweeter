require 'sinatra'
require 'twitter'

CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWITTER_CONUMER_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
end

get '/' do
  @tweets = CLIENT.user_timeline.map { |tweet| pig_latinizer(tweet.text) }
  erb :index
end

post '/tweet' do
  CLIENT.update(pig_latinizer(params[:tweet]))
  redirect '/'
end

def pig_latinizer(string)
  string.split(" ").map { |word| pig_latin_logic(word) }.join(" ")
end

def pig_latin_logic(word)
  starts_with_letter?(word) ? substitution_rule_chooser(word) : word
end

def substitution_rule_chooser(word)
  starts_with_vowel?(word) ? vowel_rule(word) : consonant_rule(word)
end

def starts_with_letter?(word)
  word[0] =~ /[a-zA-Z]/ && !(word =~ /\Ahttp/i)
end

def starts_with_vowel?(word)
  word[0] =~ /[AEIOUaeiou]/
end

def vowel_rule(word)
  word.sub(/(\w+)/, '\1way')
end

def consonant_rule(word)
  word.sub(/(\A[^AEIOUaeiou_\W\d]+)(\w+)/, '\2\1ay')
end
