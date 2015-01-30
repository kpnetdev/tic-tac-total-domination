class Board
	

	def initialize
		@squares_array = Array.new(9, "0")
	end

	def draw!
		[0,3,6].each {|begin_index| puts @squares_array[begin_index,3].join(' ')}
	end

	def update!(player, move)
		@squares_array[move - 1] = player.letter
	end

	def full?
		!@squares_array.include?("0")
	end







end