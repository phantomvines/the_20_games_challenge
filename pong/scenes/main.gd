extends Node2D

var lifes_player_1 = 3
var lifes_player_2 = 3

signal player_won(player: int)

func _on_ball_ball_hit(side: String) -> void:
	# decrease life count of player whose side got hit
	if side == "left":
		lifes_player_1 -= 1
		$lives_player_1.text = "Lifes: " + str(lifes_player_1)
	else:
		lifes_player_2 -= 1
		$lives_player_2.text = "Lifes: " + str(lifes_player_2)
	
	# check if one player has won, if yes, set scene to death scene and update player_won 
	if lifes_player_1 == 0:
		Scenemanager.player_won = 2
		get_tree().change_scene_to_file("res://scenes/death_scene.tscn")
	elif lifes_player_2 == 0:
		Scenemanager.player_won = 1
		get_tree().change_scene_to_file("res://scenes/death_scene.tscn")
