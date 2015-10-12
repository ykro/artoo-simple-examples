require 'artoo'
connection :arduino, :adaptor => :firmata, port: '/dev/cu.usbmodem1421'
device :servo, :driver => :servo, :pin => 3 

work do  
  servo.min 

  every 1.second do
    puts "Ángulo: #{servo.current_angle}"
    case servo.current_angle
      when 30 then servo.center
      when 90 then servo.max
      when 150 then servo.min
    end
  end
end