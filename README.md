# Ruby Command-line Application for Client Management

This is a minimalist command-line application built using Ruby for managing client data stored in a JSON dataset. The application offers two main commands:

1. **Search**: Searches through all clients and returns those with names partially matching a given search query.
2. **Duplicates**: Finds out if there are any clients with the same email in the dataset and shows those duplicates if any are found.

## Installation

1. Ensure you have Ruby installed on your system. If not, you can download and install it from [here](https://www.ruby-lang.org/en/documentation/installation/).
2. Clone this repository or download the project files to your local machine.

## Usage

1. Place the `clients.json` file in the same directory as the `app.rb`.
2. Open a terminal and navigate to the directory containing the `app.rb` file.
3. Run the application by executing the following command:

   ```bash
   ruby app.rb
   ```

4. The application will execute the example usage, searching for clients with a name partially matching "John" and then checking for duplicate emails.

## Code Structure

The code is divided into two main classes:

1. **ClientManager**: Responsible for parsing the JSON data and providing methods to search for clients and find duplicate emails.
   
2. **CommandLineInterface**: Provides a command-line interface for interacting with the application. It initializes a `ClientManager` object and offers methods to execute search and duplicate detection functionalities.

## Unit Testing

To run the unit tests:

1. Ensure you have Ruby installed on your system.

2. Navigate to the project directory in your terminal.

3. Install RSpec by running:

```bash
gem install rspec
```

4. Run the unit tests by executing the following command:

```bash
rspec
```
This command will run all test files in the spec directory and report the results.

Note: To satisfy other unit tests, run `ruby scripts/remove_duplicates.rb`

## Future Expansion

The application is designed to accommodate future expansions such as:

- Accepting any JSON file and making the search dynamic by allowing the user to specify which field to search for.
- Offering the same functionality on a REST API using a framework like Sinatra or Rails.
- Scaling the application by optimizing search algorithms for large datasets, using database systems for data storage, and employing distributed systems for handling high traffic loads.

## Assumptions

- The JSON dataset provided (`clients.json`) follows a specific structure with fields `id`, `full_name`, and `email`.
- The application assumes that the JSON dataset will fit into memory. For larger datasets, additional optimizations may be required.
- The search functionality is case-insensitive, i.e., searching for "John" will match "John Doe" as well as "john@example.com".

## Dependencies

The application depends on the `json` gem for parsing JSON data. It's specified in the `Gemfile`, and you can install it by running:

```bash
bundle install
```

## License

This project is licensed under the [MIT License](LICENSE).

