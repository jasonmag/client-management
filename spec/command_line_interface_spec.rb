# spec/command_line_interface_spec.rb

require_relative '../app.rb'

RSpec.describe CommandLineInterface do
  let(:json_data) { File.read('clients.json') }
  let(:cli) { described_class.new(json_data) }

  describe '#search_clients' do
    it 'displays clients with names partially matching the query' do
      expected_output = "ID: 1, Name: John Doe, Email: john.doe@gmail.com\nID: 3, Name: Alex Johnson, Email: alex.johnson@hotmail.com\n"
      expect { cli.search_clients('John') }.to output(expected_output).to_stdout
    end

    it 'displays no clients found message if no matching clients found' do
      expected_output = "No clients found.\n"
      expect { cli.search_clients('Nonexistent') }.to output(expected_output).to_stdout
    end    
  end

  describe '#find_duplicate_emails' do
    it 'displays clients with duplicate emails' do
      expected_output = "Duplicates found:\nID: 2, Name: Jane Smith, Email: jane.smith@yahoo.com\nID: 15, Name: Another Jane Smith, Email: jane.smith@yahoo.com\n"
      expect { cli.find_duplicate_emails }.to output(expected_output).to_stdout
    end

    it 'displays no duplicates found message if no duplicate emails found' do
      json_data = File.read('clients_no_duplicates.json')
      cli = described_class.new(json_data)
      expected_output = "No duplicates found.\n"
      expect { cli.find_duplicate_emails }.to output(expected_output).to_stdout
    end
  end
end
