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

# Creates a route in Sinatra which responds to the /astros file.
#
get '/astros' do
  astros = OpenNotify.astros # Fetch and save the data for astros.

  erb :astros, locals: { data: astros }
  # Render the astros.erb view.
  # Optionally, assign the astros data to 'data' for use in astros.erb
end
