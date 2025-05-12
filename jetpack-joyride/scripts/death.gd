extends Node2D

func _ready() -> void:
	$score.text = "SCORE: " + str(Scenemanager.score)

func _on_retry_pressed() -> void:
	Scenemanager.score = 0
	Scenemanager.health = 100
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_exit_pressed() -> void:
	# close scene
	get_tree().quit()
