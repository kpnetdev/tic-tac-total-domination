require './player.rb'
require 'pry'

def get_move
	square = gets.chomp.to_i
end

def new_board_hash
	board_hash = Hash.new
	(1..9).each {|number| board_hash[number] = "0"}
	board_hash
end

def update_board(players, board_hash=nil)
	board_hash = board_hash || new_board_hash
	players.each do |player|
		player.squares.each {|square| board_hash[square] = player.letter}
	end
	board_hash
end

def draw_board!(board_hash)
	[0,3,6].each {|begin_index| puts board_hash.values[begin_index,3].join(' ')}
end

def game_won?(players)
	players.map {|player| player.squares}.flatten.include?(13)
end



player_one = Player.new("Player1", "X")
player_two = Player.new("Player2", "Y")

players = [player_one, player_two]

until game_won?(players)
	current_player, other_player = players.reverse!
	board_hash = update_board(players, board_hash)
	draw_board!(board_hash)
	square = get_move
	current_player.choose_square(square)
	other_player.lose_square(square)
end
