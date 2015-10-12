require 'artoo'
connection :arduino, :adaptor => :firmata, port: '/dev/cu.usbmodem1421'
device :sensor, driver: :analog_sensor, pin: 0, interval: 0.25

work do
  every 1.second do
    voltage  = ( sensor.analog_read(sensor.pin) * 5000 ) / 1024
    tempc    = voltage / 10
    puts "#{tempc} C"
  end

  on sensor, :upper => proc {
    puts "Límite superior!"
  }

  on sensor, :lower => proc {
    puts "Límite inferior!"
  }
end