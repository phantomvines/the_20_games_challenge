extends Node2D

var board = []

func _ready() -> void:
	init_array(10)
	print(board)



# makes a quadratic 2D-Array filled with zeros, based on size
func init_array(size) -> void:
	for i in range(size):
		board.append([])
		for j in range(size): 
			board[i].append(0)
