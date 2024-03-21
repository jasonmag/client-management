require 'sinatra'
require 'json'

# Load the client data from the JSON file
CLIENTS_DATA = JSON.parse(File.read('clients.json'))

# Search clients endpoint
get '/search' do
  query = params[:q]
  fields = params[:fields] ? params[:fields].split(',') : ['full_name'] # Split fields string into an array
  results = search_clients(query, fields)
  content_type :json
  results.to_json
end

# Helper method to search clients
def search_clients(query, fields)
  CLIENTS_DATA.select do |client|
    fields.any? do |field|
      client[field].to_s.downcase.include?(query.downcase)
    end
  end
end
