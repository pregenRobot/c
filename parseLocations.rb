require "ferrum"
require "nokogiri"

#browser = Ferrum::Browser.new

urls = File.open("fb_profile_urls").readlines.map{|url| url.strip}


browser = Ferrum::Browser.new(timeout: 20)
browser.headers.set({
  "authority" => 'authority: www.facebook.com',
  'cache-control' => 'max-age=0',
  'viewport-width' => '2560',
  'sec-ch-ua' => '"Not;A Brand";v="99", "Google Chrome";v="91", "Chromium";v="91"',
  'sec-ch-ua-mobile'=> '?0',
  'upgrade-insecure-requests' => '1',
  'user-agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.164 Safari/537.36' ,
  'accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' ,
  'sec-fetch-site' => 'same-origin' ,
  'sec-fetch-mode' => 'navigate' ,
  'sec-fetch-user' => '?1' ,
  'sec-fetch-dest' => 'document' ,
  'accept-language' => 'en-GB,en-US;q=0.9,en;q=0.8' ,
})

urls.each do |url|
  id = url.split("/").last

  if `ls -la | grep html`.include?(id)
    pp "NEXT: #{id}"
    next
  end

  pp "#{id}"

  sleep_time =  (rand() * 10).to_i
  pp "sleep_time: #{sleep_time}"
  sleep sleep_time
  browser.go_to(url)

  begin
    browser.network.wait_for_idle
  rescue
  end
  #puts Nokogiri::HTML.parse(browser.body).at_css("span.j5wam9gi.e9vueds3.m9osqain")&.text
  File.open("#{id}.html", "w+"){|f| f.write (browser.body)}
end

#browser.go_to("https://google.com")
#input = browser.at_xpath("//input[@name='q']")
#input.focus.type("Ruby headless driver for Chrome", :Enter)
#browser.at_css("a > h3").text # => "rubycdp/ferrum: Ruby Chrome/Chromium driver - GitHub"
#browser.quit
