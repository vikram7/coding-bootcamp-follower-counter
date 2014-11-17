require 'twitter'
require 'pry'

bootcamps = ["launchacademy_", "turingschool", "gSchool", "thisismetis", "appacademyio", "FlatironSchool", "HackReactor", "devbootcamp", "StartupInst", "GA_boston", "GA"]
intelligence = Hash.new

config = {
  consumer_key:    ENV["CONSUMER_KEY"],
  consumer_secret: ENV["CONSUMER_SECRET"]
}

client = Twitter::REST::Client.new(config)

bootcamps.each do |username|
  bootcamp = client.user(username)
  followers = bootcamp.followers_count
  friends = bootcamp.friends_count
  tweets = bootcamp.statuses_count
  intelligence[username] = { followers: followers, friends: friends, tweets: tweets }
end

sorted = intelligence.sort_by { |_, value| -value[:followers] }

printf "%-20s %-10s %-10s %-10s\n", "bootcamp", "#followers", "#friends", "#tweets"
sorted.each do |bootcamp|
  name = bootcamp.first
  followers = bootcamp.last[:followers]
  friends = bootcamp.last[:friends]
  tweets = bootcamp.last[:tweets]
  printf "%-20s %-10s %-10s %-10s\n", name, followers, friends, tweets
end
