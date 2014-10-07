require 'sinatra'
require 'twitter'
require 'pry'

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
  trailing_punctuation = word.match(/\W+\z/).to_s
  word.sub!(/\W+\z/, "")
  word + "way" + trailing_punctuation
end

def consonant_rule(word)
  pattern = /\A[^AEIOUaeiou_\W\d]+/
  pig_word = word.sub(pattern, "")
  # check for end bits like !,; etc
  trailing_punctuation = pig_word.match(/\W+\z/).to_s
  pig_word.sub!(/\W+\z/, "")
  # apply consonant pig latin rule
  word.match(pattern) { |m| pig_word = "#{pig_word}#{m}ay" }
  # add end bits
  pig_word += trailing_punctuation
  # return the freshly formatted word
  pig_word
end
