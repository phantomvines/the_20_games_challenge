extends Node2D

# preload scenes
@export var projectile: PackedScene = preload("res://scenes/projectile.tscn")
# spawning frequencies
@export var projectile_frequency = 0.05

func _physics_process(delta: float) -> void:
	# get random float between 0 and 1
	var rand = randf()
	
	# spawn projectiles
	if rand <= projectile_frequency:
		spawn_projectile()


func spawn_projectile() -> void:
	var projectile_instance = projectile.instantiate()
	add_child(projectile_instance)
	projectile_instance.position = Vector2(1200, randf_range(30, 600))
