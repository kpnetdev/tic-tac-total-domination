require 'sinatra'
require 'json'
require 'pry'

require './game.rb'

set :public_folder, 'public'

get '/' do
  redirect '/index.html'
end

get '/ajax' do
	content_type :json
	board = params[:boardArray]
	game_over = !board.include?("")
	computer_move = Game.get_computer_move(board)
	{ :squareId => computer_move, :gameOver => game_over }.to_json
end
