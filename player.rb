class Player
	attr_accessor :name, :winning_combos, :squares, :letter

	def initialize(name, letter)
		@name = name
		@letter = letter
		@winning_combos = get_winning_combos
		@squares = []
	end

	def add_square(square)
		@squares << square
	end

	def lose_square(square)
		@winning_combos.each {|combo| combo.delete(square)}
	end

	def lost?
		@winning_combos.select {|combo| combo.empty?}.first
	end

	private

	def get_winning_combos
		horizontals = [[1,2,3],[4,5,6],[7,8,9]]
		verticals = horizontals.transpose
		diagonals = [[1,5,9],[3,5,7]]
		winning_combos = horizontals + verticals + diagonals
	end
end
