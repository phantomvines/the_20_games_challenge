extends Node2D

# preload scenes
@export var projectile: PackedScene = preload("res://scenes/projectile.tscn")
@export var heart: PackedScene = preload("res://scenes/heart.tscn")
@export var damage_area: PackedScene = preload("res://scenes/damage_area.tscn")
@export var coin: PackedScene = preload("res://scenes/coin.tscn")
@export var shooting_enemy: PackedScene = preload("res://scenes/shooting_enemy.tscn")
@export var invincibility_potion: PackedScene = preload("res://scenes/invincibility_potion.tscn")
# spawning frequencies
@export var projectile_frequency = 0.03
@export var heart_frequency = 0.005
@export var damage_area_frequency = 0.02
@export var coin_frequency = 0.01
@export var shooting_enemy_frequency = 0.008
@export var invincibility_potion_frequency = 0.003

var segment_change_frequency = 0.001
var difficulty_increase_frequency = 0.001

# difficulty to increase
var difficulty = 0

# speed of health reduction
var health_reduc_speed = 0.5
var curr_health = Scenemanager.health

# Different gameplay segments
var projectiles = false
var areas = false
var shooting_enemies = true
var segments = ["nothing", "projectiles", "areas", "shooting enemies"]
var last_segment = "shooting_enemies"

# to store if game is paused
var paused = false

#func _ready() -> void:
#	$pause_menu.pause_mode = Node.PAUSE_MODE_PROCESS

func _physics_process(delta: float) -> void:
	# if invincible, do not allow health_changes
	if Scenemanager.invincible:
		if Scenemanager.health < curr_health:
			Scenemanager.health = curr_health
	
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
	
	# check if game should be paused
	check_pause()
	
	# get random float between 0 and 1
	var rand = randf()
	
	# increase difficulty
	if rand <= difficulty_increase_frequency:
		difficulty += 0.002
	
	# change scene
	if rand <= segment_change_frequency:
		change_segment()
	
	# spawn projectiles
	if rand <= projectile_frequency+difficulty and projectiles:
		spawn_projectile()
		
	# spawn shooting enemies
	if rand <= shooting_enemy_frequency+difficulty and shooting_enemies:
		spawn_shooting_enemy()
		
	# spawn hearts
	if rand <= heart_frequency:
		spawn_heart()
	
	# spawn damage area
	if rand < damage_area_frequency+difficulty and areas:
		spawn_damage_area()
	
	# spawn coins
	if rand < coin_frequency:
		spawn_coin()
		
	# spawn invincibility potions
	if rand < invincibility_potion_frequency:
		spawn_invincibility_potion()
	
	# check if player is dead
	if Scenemanager.health <= 0 and not Scenemanager.invincible:
		get_tree().change_scene_to_file("res://scenes/death.tscn")
	

# function to check if game should be paused/unpaused
func check_pause() -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		$pause_menu/pause_label.visible = true
		$pause_menu/pause_button.visible = true
		$pause_menu/pause_button.disabled = false

# change segment to new one
func change_segment():
	# get random segment
	var segment = segments[randi() % segments.size()]
	print(segment)
	
	# change bools for object spawning
	if segment == "nothing":
		areas = false
		projectiles = false
		shooting_enemies = false
	elif segment == "projectiles":
		areas = false
		projectiles = true
		shooting_enemies = false
	elif segment == "areas":
		areas = true
		projectiles = false
		shooting_enemies = false
	elif segment == "shooting enemies":
		areas = false
		projectiles = false
		shooting_enemies = true
	
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
	damage_area_instance.position = Vector2(1200, randf_range(80, 530))
	
func spawn_coin() -> void:
	var coin_instance = coin.instantiate()
	add_child(coin_instance)
	coin_instance.position = Vector2(1200, randf_range(30, 600))

func spawn_invincibility_potion() -> void:
	var invincibility_potion_instance = invincibility_potion.instantiate()
	add_child(invincibility_potion_instance)
	invincibility_potion_instance.position = Vector2(1200, randf_range(30, 600))

func spawn_shooting_enemy() -> void:
	var shooting_enemy_instance = shooting_enemy.instantiate()
	add_child(shooting_enemy_instance)
	shooting_enemy_instance.position = Vector2(1200, randf_range(100, 530))


func _on_pause_button_pressed() -> void:
	get_tree().paused = false
	$pause_menu/pause_label.visible = false
	$pause_menu/pause_button.visible = false
	$pause_menu/pause_button.disabled = true
