extends Node2D

var lifes_player_1 = 3
var lifes_player_2 = 3

func _on_ball_ball_hit(side: String) -> void:
	if side == "left":
		lifes_player_1 -= 1
		$lives_player_1.text = "Lifes: " + str(lifes_player_1)
	else:
		lifes_player_2 -= 1
		$lives_player_2.text = "Lifes: " + str(lifes_player_2)
