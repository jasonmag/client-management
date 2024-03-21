require 'json'

class ClientManager
  def initialize(data)
    @clients = JSON.parse(data)
  end

  def search_clients(query, fields = ['full_name'])
    if fields.is_a?(Array)
      results = @clients.select do |client|
        fields.any? { |field| client[field].to_s.downcase.include?(query.downcase) }
      end
    else
      results = @clients.select { |client| client[fields].to_s.downcase.include?(query.downcase) }
    end
    results
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

  def search_clients(query, field = 'full_name')
    results = @manager.search_clients(query, field)
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
  puts 'Searching for clients with name containing "John":'
  cli.search_clients("John")
  puts "\nFinding duplicate emails:"
  cli.find_duplicate_emails
end