
def get_winning_combos
	horizontals = [[1,2,3],[4,5,6],[7,8,9]]
	verticals = horizontals.transpose
	diagonals = [[1,5,9],[3,5,7]]
	winning_combos = horizontals + verticals + diagonals
end



