# frozen_string_literal: true

require 'json'
require 'faraday'

# Fetch data from the OpenNotify API service at http://api.open-notify.org/
module OpenNotify
  BASE_DIR = __dir__

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
  end

  def fetch_data(api:)
    if USE_LIVE_DATA == 'yes'
      conn = Faraday.new('http://api.open-notify.org/') do |f|
        f.response :json
      end

      return conn.get("#{api}.json").body
    end

    filepath = File.join(BASE_DIR, 'data', "#{api}.json")
    JSON.parse(File.read(filepath))
  end

  module_function :iss_now, :astros, :fetch_data
end
