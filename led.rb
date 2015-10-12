require 'artoo'
connection :arduino, :adaptor => :firmata, port: '/dev/cu.usbmodem1421'
device :led, :driver => :led, :pin => 13

work do
  every 1.second do
    led.on? ? led.off : led.on
  end
end