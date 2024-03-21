#!/usr/bin/env ruby
require 'json'

# Set the path to the clients.json file
clients_json_path = File.expand_path('../../clients.json', __FILE__)

# Read clients.json file
clients_data = File.read(clients_json_path)
clients = JSON.parse(clients_data)

# Remove duplicates based on email field
clients_no_duplicates = clients.uniq { |client| client['email'] }

# Set the path to the clients_no_duplicates.json file
output_file_path = File.expand_path('../../clients_no_duplicates.json', __FILE__)

# Write to clients_no_duplicates.json file
File.open(output_file_path, 'w') do |file|
  file.write(JSON.pretty_generate(clients_no_duplicates))
end

puts "Duplicates removed. Output saved to #{output_file_path}"
