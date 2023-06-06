# frozen_string_literal: true

# myapp.rb
require 'sinatra'
require_relative 'open_notify'

# Allow our templates in views/ to end in `.html.erb`
Tilt.register Tilt::ERBTemplate, 'html.erb'

set :layout, 'views/layout.html.erb'

get '/' do
  erb :index
end

get '/position' do
  iss_now = OpenNotify.iss_now

  erb :position, locals: { data: iss_now }
end

# Create route in Sinatra, fetches and stores astros data, renders in astros view.
#
get '/astros' do
  astros = OpenNotify.astros

  erb :astros, locals: { data: astros }
  # Optionally, assign the astros data to 'data' for use in astros.erb
end

# Endpoint to return ISS position as json
# Fetch and save the data, optionally(?) indicate JSON response
# Convert to JSON and direct to endpoint.
#
get '/iss_position.json' do
  iss_now = OpenNotify.iss_now
  content_type :json
  iss_now.to_json
end
