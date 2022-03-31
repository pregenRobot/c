require "json"

result = File.open("userIds.json").read

parsedIds = result.split(",")
  .map{|line| line.strip.to_i}


File.open("fb_profile_urls", "w+") do |f|
  parsedIds.each{ |id| 
    f.puts("https://www.facebook.com/#{id}") 
  }
end
