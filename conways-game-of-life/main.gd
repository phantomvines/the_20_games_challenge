extends Node2D

var board = []

func _ready() -> void:
	init_array(10)
	fill_random()
	print(board)

func update_conway() -> void:
	var board_new = 

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
