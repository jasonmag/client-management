# spec/client_manager_spec.rb

require 'json'
require_relative '../app.rb'

RSpec.describe ClientManager do
  let(:json_data) { File.read('clients.json') }
  let(:manager) { described_class.new(json_data) }

  describe '#search_clients' do
    it 'returns clients with names partially matching the query' do
      results = manager.search_clients('John')
      expect(results.size).to be > 1
      expect(results.first['full_name']).to include('John')
    end

    it 'returns empty array if no matching clients found' do
      results = manager.search_clients('Nonexistent')
      expect(results).to be_empty
    end
  end

  describe '#find_duplicate_emails' do
    it 'returns clients with duplicate emails' do
      duplicates = manager.find_duplicate_emails
      expect(duplicates.size).to be > 1
      expect(duplicates.first['email']).to eq('jane.smith@yahoo.com')
    end

    it 'returns nil if no duplicate emails found' do
      json_data = File.read('clients_no_duplicates.json')
      manager = described_class.new(json_data)
      duplicates = manager.find_duplicate_emails
      expect(duplicates).to be_nil
    end
  end
end
