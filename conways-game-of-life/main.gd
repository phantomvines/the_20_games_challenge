extends Node2D

var board = []

func _ready() -> void:
	init_array(10)
	fill_random()
	print(board)

# fill the board with 0 and 1 randomly
func fill_random() -> void:
	for i in range(board.size()):
		for j in range(board[0].size()):
			board[i][j] = randi_range(0,1)

# makes a quadratic 2D-Array filled with zeros, based on size
func init_array(size) -> void:
	for i in range(size):
		board.append([])
		for j in range(size): 
			board[i].append(0)
