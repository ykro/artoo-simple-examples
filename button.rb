require 'artoo'
connection :arduino, :adaptor => :firmata, port: '/dev/cu.usbmodem1421'
device :led, :driver => :led, :pin => 13
device :button, driver: :button, pin: 2

work do
  puts "Botón conectado al pin #{ button.pin }..."

  on button, :push    => proc { led.on }
  on button, :release => proc { led.off }
end