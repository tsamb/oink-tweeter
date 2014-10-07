require 'sinatra'
require 'twitter'
require 'pry'

CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = "jMuouCRuzjMNYTZ1c8aBaJK7S"
  config.consumer_secret     = "b7ZIyHsBCxidq0T4qQhAfUvKxqgqyHr2XKjKmAjCZAq1gRI3yU"
  config.access_token        = "56865897-P1CkEOGdogIktMG93PIEVm7NbCAIFd0yJVdkBmOyl"
  config.access_token_secret = "Qu9Qep0dE6hwCsSPNMWxDfKkQOLHeZcaMwid51CnKnSHA"
end

get '/' do
  # binding.pry
  @tweets = CLIENT.user_timeline
  erb :index
end

def pig_latinizer(string)
  string.split(" ").map { |word| pig_latin_logic(word) }.join(" ")
end

def pig_latin_logic(word)
  if starts_with_letter?(word)
    starts_with_vowel?(word) ? vowel_rule(word) : consonant_rule(word)
  end
end

def starts_with_letter?(word)
  word[0] =~ /[a-zA-Z]/
end

def starts_with_vowel?(word)
  word[0] =~ /[AEIOUaeiou]/
end

def vowel_rule(word)
  word + "way"
end

def consonant_rule(word)
  pattern = /\A[^AEIOUaeiou]+/
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
