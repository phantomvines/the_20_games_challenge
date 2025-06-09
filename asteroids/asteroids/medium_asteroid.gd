extends Node2D

@export var small_asteroid: PackedScene = preload("res://asteroids/small_asteroid.tscn")

@export var speed = 80

# default direction vector
var dir = Vector2(1,0)

func _physics_process(delta: float) -> void:
	position += dir*speed*delta

# when player hits asteroid
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Scenemanager.lifes -= 1
		destroy_asteroid()

# when bullet hits asteroid
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_bullet"):
		destroy_asteroid()
	

func destroy_asteroid() -> void:
	# split in two smaller asteroids or be destroyed when smallest
	var small_asteroid_1 = small_asteroid.instantiate()
	var small_asteroid_2 = small_asteroid.instantiate()
	
	get_parent().add_child(small_asteroid_1)
	get_parent().add_child(small_asteroid_2)

	
	# set asteroid position to position of mother asteroid
	small_asteroid_1.position = position
	small_asteroid_2.position = position
	
	# assign random directions to asteroids
	small_asteroid_1.dir = Vector2.RIGHT.rotated(randf() * PI * 2).normalized()
	small_asteroid_2.dir = Vector2.RIGHT.rotated(randf() * PI * 2).normalized()
		
	# destroy original asteroid
	queue_free()
