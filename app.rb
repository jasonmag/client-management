# app.rb

require 'json'

class ClientManager
  def initialize(data)
    @clients = JSON.parse(data)
  end

  def search_clients(query)
    @clients.select { |client| client['full_name'].downcase.include?(query.downcase) }
  end

  def find_duplicate_emails
    duplicates = @clients.group_by { |client| client['email'] }
                        .select { |_, clients| clients.size > 1 }
                        .values.flatten
    duplicates unless duplicates.empty?
  end
end

class CommandLineInterface
  def initialize(data)
    @manager = ClientManager.new(data)
  end

  def search_clients(query)
    results = @manager.search_clients(query)
    if results.empty?
      puts "No clients found."
    else
      display_results(results)
    end
  end

  def find_duplicate_emails
    duplicates = @manager.find_duplicate_emails
    if duplicates
      puts "Duplicates found:"
      display_results(duplicates)
    else
      puts "No duplicates found."
    end
  end

  private

  def display_results(results)
    results.each do |client|
      puts "ID: #{client['id']}, Name: #{client['full_name']}, Email: #{client['email']}"
    end
  end
end

# Main entry point
if __FILE__ == $0
  json_data = File.read('clients.json')
  cli = CommandLineInterface.new(json_data)

  # Example usage
  cli.search_clients("John")
  cli.find_duplicate_emails
end

