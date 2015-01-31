require 'pry'

class Board


	def initialize
		@squares_array = Array.new(9, "0")
	end

	def draw!
		[0,3,6].each {|begin_index| puts @squares_array[begin_index,3].join(' ')}
	end

	def update!(computer, human_player)
		[computer, human_player].each do |player|
			# puts "player_squares: #{player.squares}"
			player.squares.each do |square|
				@squares_array[square - 1] = player.letter
			end
		end
	end

	def full?
		!@squares_array.include?("0")
	end







end