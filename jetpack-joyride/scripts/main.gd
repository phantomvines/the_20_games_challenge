extends Node2D

# preload scenes
@export var projectile: PackedScene = preload("res://scenes/projectile.tscn")
@export var heart: PackedScene = preload("res://scenes/heart.tscn")
@export var damage_area: PackedScene = preload("res://scenes/damage_area.tscn")
@export var coin: PackedScene = preload("res://scenes/coin.tscn")
# spawning frequencies
@export var projectile_frequency = 0.05
@export var heart_frequency = 0.005
@export var damage_area_frequency = 0.03
@export var coin_frequency = 0.01

var segment_change_frequency = 0.001

# speed of health reduction
var health_reduc_speed = 0.5
var curr_health = Scenemanager.health

# Different gameplay segments
var projectiles = false
var areas = false
var segments = ["nothing", "projectiles", "areas"]
var last_segment = "nothing"

func _physics_process(delta: float) -> void:
	# update health label
	if curr_health > Scenemanager.health:
		curr_health -= health_reduc_speed
	#elif curr_health < Scenemanager.health: 
		#curr_health += health_reduc_speed * 2
	#elif abs(curr_health-Scenemanager.health) < 1:
		#curr_health = Scenemanager.health
	if curr_health < Scenemanager.health:
		curr_health = Scenemanager.health
	$health_bar.value = curr_health
	
	# update coins label
	$coin_counter/Label.text = str(Scenemanager.score)
	
	# get random float between 0 and 1
	var rand = randf()
	
	# change scene
	if rand <= segment_change_frequency:
		change_segment()
	
	# spawn projectiles
	if rand <= projectile_frequency and projectiles:
		spawn_projectile()
		
	# spawn hearts
	if rand <= heart_frequency:
		spawn_heart()
	
	# spawn damage area
	if rand < damage_area_frequency and areas:
		spawn_damage_area()
	
	# spawn coins
	if rand < coin_frequency:
		spawn_coin()
		
	# check if player is dead
	if Scenemanager.health <= 0:
		get_tree().change_scene_to_file("res://scenes/death.tscn")

func change_segment():
	# get random segment
	var segment = segments[randi() % segments.size()]
	print(segment)
	
	# change bools for object spawning
	if segment == "nothing":
		areas = false
		projectiles = false
	elif segment == "projectiles":
		areas = false
		projectiles = true
	elif segment == "areas":
		areas = true
		projectiles = false
	
	# do not repeat the last segment
	if segment == last_segment:
		change_segment()
	else:
		last_segment = segment
	

# Spawn functions
func spawn_projectile() -> void:
	var projectile_instance = projectile.instantiate()
	add_child(projectile_instance)
	projectile_instance.position = Vector2(1200, randf_range(30, 600))

func spawn_heart() -> void:
	var heart_instance = heart.instantiate()
	add_child(heart_instance)
	heart_instance.position = Vector2(1200, randf_range(30, 600))
	
func spawn_damage_area() -> void:
	var damage_area_instance = damage_area.instantiate()
	add_child(damage_area_instance)
	damage_area_instance.position = Vector2(1200, randf_range(100, 530))
	
func spawn_coin() -> void:
	var coin_instance = coin.instantiate()
	add_child(coin_instance)
	coin_instance.position = Vector2(1200, randf_range(30, 600))
