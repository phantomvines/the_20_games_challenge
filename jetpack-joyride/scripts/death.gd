extends Node2D

func _ready() -> void:
	# store the score in highscore file, if it was bigger
	if(load_high_score() < Scenemanager.score):
		save_high_score(Scenemanager.score)
	
	$score.text = "SCORE: " + str(Scenemanager.score)
	$highscore.text = "HIGHSCORE: " + str(load_high_score())

func _on_retry_pressed() -> void:
	Scenemanager.score = 0
	Scenemanager.health = 100
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_exit_pressed() -> void:
	# close scene
	get_tree().quit()

func save_high_score(score: int) -> void:
	var file = FileAccess.open("user://highscore.txt", FileAccess.WRITE)
	file.store_line(str(score))
	file.close()

func load_high_score() -> int:
	if FileAccess.file_exists("user://highscore.txt"):
		var file = FileAccess.open("user://highscore.txt", FileAccess.READ)
		var line = file.get_line()
		file.close()
		return int(line)
	else:
		return 0  # default score if file doesn't exist
