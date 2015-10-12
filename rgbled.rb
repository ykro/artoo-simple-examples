require 'artoo'
connection :arduino, :adaptor => :firmata, port: '/dev/cu.usbmodem1421'

work do
  rgbled("#0011FF", {r: 6, g: 5, b: 3})
end

def rgbled(color, pins)
  r = 255 - color[1,2].hex	
  g = 255 - color[3,2].hex	
  b = 255 - color[5,2].hex

  adaptor = connections[:arduino].adaptor
  adaptor.pwm_write(pins[:r],r)
  adaptor.pwm_write(pins[:g],g)
  adaptor.pwm_write(pins[:b],b)
end	
