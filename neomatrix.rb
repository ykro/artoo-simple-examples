require "artoo"
require "artoo-neopixel"

connection :arduino, :adaptor => :firmata, port: '/dev/cu.usbmodem1421'
device :matrix, driver: :neomatrix, pin: 6, width: 3, height: 3

work do
  loop do
    x = (3*rand).round
    y = (3*rand).round
    red = (100*rand).round
    green = (100*rand).round
    blue = (100*rand).round
    matrix.on(x, y, red, green, blue)
    sleep 0.01
  end
end