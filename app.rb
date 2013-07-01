require 'rubygems'
require 'bundler'

Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

module Citibike
	class App < Sinatra::Application
    before do
      json = File.open("data/citibikenyc.json").read
      @data = MultiJson.load(json)
    end

    get '/' do
      erb :home
    end

    get '/form' do
      erb :form
    end

    post '/map' do
      @start = params[:start]
      @end = params[:end]
      @start_station = @data.select{|station| station["name"] == @start}.first
      @end_station = @data.select{|station| station["name"] == @end}.first
      @start_lat = @start_station["lat"]/1000000.to_f
      @start_lng = @start_station["lng"]/1000000.to_f
      @end_lat = @end_station["lat"]/1000000.to_f
      @end_lng = @end_station["lng"]/1000000.to_f
      erb :map
    end

  end
end