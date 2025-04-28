extends Node2D

func _ready() -> void:
	$score_label.text = "Score: " + str(Scenemanager.points)

func _on_retry_pressed() -> void:
	Scenemanager.points = 0
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_exit_pressed() -> void:
	# close scene
	get_tree().quit()
