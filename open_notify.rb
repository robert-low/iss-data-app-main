# frozen_string_literal: true

require 'json'
require 'faraday'

# Fetch data from the OpenNotify API service at http://api.open-notify.org/
module OpenNotify
  BASE_DIR = __dir__ # Current working directory of our code.

  # To allow this to work without internet access, the read data method just
  # loads and parses the data
  #
  # Change this to 'yes' if you want to use the live data.
  USE_LIVE_DATA = 'no'

  def iss_now
    fetch_data(api: 'iss-now')
  end

  def astros
    fetch_data(api: 'astros')
    # Calls the fetch_data method below, with the .JSON file given as an argument.
  end

  def fetch_data(api:)
    # OpenNotify#fetch_data retrieves data in JSON, either from the live API endpoint, or from the local data json files.

    if USE_LIVE_DATA == 'yes'
      # Make an HTTP request to the URL using Faraday, a Ruby HTTP client library.
      # In the block, tell Faraday to parse the response as json.
      conn = Faraday.new('http://api.open-notify.org/') do |f|
        f.response :json
      end

      return conn.get("#{api}.json").body # http://api.open-notify.org/live-endpoint.json
      #
      # Make a GET request to the OpenNotify API which specifies the endpoint in documentation (iss-now or astros)
      # Extract the response body as a string.
      # .body returns the response object as a string, hence the "no implicit conversion of array into string error"
    end

    filepath = File.join(BASE_DIR, 'data', "#{api}.json") # File path of API endpoint -> '/data/'file-endpoint.json'
    JSON.parse(File.read(filepath)) # Read and return the parsed data from the file.
  end

  module_function :iss_now, :astros, :fetch_data
end
