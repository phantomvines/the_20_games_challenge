extends Node2D


func _ready() -> void:
	$Label.text = "Lifes: " + str(Scenemanager.lifes)

func _physics_process(delta: float) -> void:
	$Label.text = "Lifes: " + str(Scenemanager.lifes)
	
	# Deathd
	if Scenemanager.lifes <= 0:
		queue_free()
