require "artoo"
require "artoo-neopixel"
require "twitter"
require "sentimentalizer"

connection :arduino, :adaptor => :firmata, port: '/dev/cu.usbmodem1421'
device     :matrix, driver: :neomatrix, pin: 6, width: 3, height: 3

query = ARGV[0] || "jsconfco"
analyzed = []

client = Twitter::REST::Client.new do |config|
  config.consumer_key    = "<KEY>"
  config.consumer_secret = "<SECRET>"
end

Sentimentalizer.setup

work do
  allOff
  every 15.second do  
    puts "obteniendo tweets"
    #result_type: "recent"
    client.search(query, result_type: "mixed").take(5).each do |tweet|  
      unless analyzed.include? tweet.text
        analyzed << tweet.text
        begin 
          sentiment = Sentimentalizer.analyze(tweet.text).sentiment        
        rescue NoMethodError #NoMethodError: undefined method `+' for nil:NilClass
          sentiment = ":|"
        end

        allOn(255,255,0) if sentiment.eql? ":)"
        allOn(0,0,255) if sentiment.eql? ":("
        allOn(0,255,0) if sentiment.eql? ":|"
        sleep 2
        allOff
        sleep 1
      end
    end

    #puts analyzed.length
    #analyzed.each {|t| puts t}
    #puts "\n\n"
  end
end

def allOn(red,green,blue)  
  (0..3).each do |x| 
    (0..3).each do |y|
      matrix.on(x, y, red, green, blue)     
    end
  end
end

def allOff
  (0..3).each do |x| 
    (0..3).each do |y|
      matrix.off x,y
    end
  end  
end

def rainbow
  (0..3).each do |x| 
    (0..3).each do |y|
      red = (255*rand).round
      green = (255*rand).round
      blue = (255*rand).round        
      matrix.on(x, y, red, green, blue)
    end
  end    
end 