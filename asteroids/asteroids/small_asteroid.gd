extends Node2D

@export var speed = 80

# default direction vector
var dir = Vector2(1,0)

func _physics_process(delta: float) -> void:
	position += dir*speed*delta

# when player hits asteroid
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Scenemanager.lifes -= 1

# when bullet hits asteroid
func _on_area_2d_area_entered(area: Area2D) -> void:
	# split in two smaller asteroids or be destroyed when smallest
	if area.is_in_group("player_bullet"):
		queue_free()
