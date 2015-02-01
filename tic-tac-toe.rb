require 'sinatra'
require 'json'

require './game.rb'

set :public_folder, 'public'

get '/' do
  redirect '/index.html'
end

get '/ajax' do
	content_type :json
	board = params[:squareId]
	{ :squareId => '#s1' }.to_json
end
