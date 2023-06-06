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

  # Calls the fetch_data method below, with the .JSON file given as an argument.
  #
  def astros
    fetch_data(api: 'astros')
  end

  # Retrieves data in JSON, either from the live API endpoint, or from the local data json files.
  #
  def fetch_data(api:)
    # Make an HTTP request to the URL using Faraday, a Ruby HTTP client library, parse as JSON.
    #
    if USE_LIVE_DATA == 'yes'
      conn = Faraday.new('http://api.open-notify.org/') do |f|
        f.response :json
      end

      # GET request to API endpoint, return the response object as a string.
      #
      return conn.get("#{api}.json").body # 'http://api.open-notify.org/#{live-endpoint-here}.json'
    end

    # If local file, then below is executed, with endpoint -> '/data/'#{file-endpoint-here}.json'
    #
    filepath = File.join(BASE_DIR, 'data', "#{api}.json")
    JSON.parse(File.read(filepath))
  end

  module_function :iss_now, :astros, :fetch_data
end
