require 'artoo'
connection :arduino, :adaptor => :firmata, port: '/dev/cu.usbmodem1421'
device :sensor, driver: :analog_sensor, pin: 0, interval: 0.25

work do
  puts "Valor inicial #{ sensor.analog_read(0) }"
  puts "Límites son #{ sensor.lower } y #{ sensor.upper }"

  every 1.second do
    puts sensor.analog_read(sensor.pin) 
  end

  on sensor, :upper => proc {
    puts "Límite superior!"
  }

  on sensor, :lower => proc {
    puts "Límite inferior!"
  }
end