extends Node2D

# preload scenes
@export var projectile: PackedScene = preload("res://scenes/projectile.tscn")
@export var heart: PackedScene = preload("res://scenes/heart.tscn")
# spawning frequencies
@export var projectile_frequency = 0.05
@export var heart_frequency = 0.01

# speed of health reduction
var health_reduc_speed = 0.5
var curr_health = Scenemanager.health

func _physics_process(delta: float) -> void:
	# update health label
	if curr_health > Scenemanager.health:
		curr_health -= health_reduc_speed
	elif curr_health < Scenemanager.health: 
		curr_health += health_reduc_speed * 2
	$health_bar.value = curr_health
	
	# get random float between 0 and 1
	var rand = randf()
	
	# spawn projectiles
	if rand <= projectile_frequency:
		spawn_projectile()
		
	# spawn hearts
	if rand <= heart_frequency:
		spawn_heart()


func spawn_projectile() -> void:
	var projectile_instance = projectile.instantiate()
	add_child(projectile_instance)
	projectile_instance.position = Vector2(1200, randf_range(30, 600))

func spawn_heart() -> void:
	var heart_instance = heart.instantiate()
	add_child(heart_instance)
	heart_instance.position = Vector2(1200, randf_range(30, 600))
