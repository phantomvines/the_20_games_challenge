extends Node2D

func _ready() -> void:
	$win_label.text = "PLAYER " + str(Scenemanager.player_won) + " WON!"

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_exit_pressed() -> void:
	# close scene
	get_tree().quit()
