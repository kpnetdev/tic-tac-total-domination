require 'sinatra'
require 'json'
require './game.rb'

set :public_folder, 'public'

get '/' do
  redirect '/index.html'
end

get '/ajax' do
	content_type :json
	board = params[:boardArray]
	computer_move = Game.get_computer_move(board)
	{ :squareId => computer_move[:computer_square], :gameOver => computer_move[:computer_won] }.to_json
end
