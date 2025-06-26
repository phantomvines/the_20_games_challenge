extends Node2D

var board = []

func _ready() -> void:
	board = init_array(10)
	fill_random()
	print(board)

# update the board once
func update_conway() -> void:
	# new, blank board
	var board_new = init_array(board.size)
	for i in range(board.size()):
		for j in range(board.size()):
			# all of the middle squares, not the edges
			if i >= 1 and j >= 1 and i <= board.size() and j <= board.size():
				var total = 0
				
				# add all states of surrounding and self together
				for x in range(i-1,i+1):
					for y in range(j-1,j+1):
						total += board[x][y]
				
				# subtract own value
				total -= board[i][j]
				
				# set new live values
				if total == 3 or total == 2 and board[i][j] == 1: # sustain
					board_new[i][j] = 1
				elif total == 4 and board[i][j] == 0: # reproduction
					board_new[i][j] = 1

# fill the board with 0 and 1 randomly
func fill_random() -> void:
	for i in range(board.size()):
		for j in range(board[0].size()):
			board[i][j] = randi_range(0,1)

# makes a quadratic 2D-Array filled with zeros, based on size
func init_array(size):
	var new_board
	for i in range(size):
		new_board.append([])
		for j in range(size): 
			new_board[i].append(0)
	return new_board
