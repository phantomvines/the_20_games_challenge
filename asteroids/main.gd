extends Node2D

@export var small_asteroid: PackedScene = preload("res://asteroids/small_asteroid.tscn")
@export var medium_asteroid: PackedScene = preload("res://asteroids/medium_asteroid.tscn")
@export var big_asteroid: PackedScene = preload("res://asteroids/big_asteroid.tscn")

# asteroid spawn rate
@export var asteroid_spawn_rate = 0.001

func _ready() -> void:
	$Label.text = "Lifes: " + str(Scenemanager.lifes)

func _physics_process(delta: float) -> void:
	#$Label.text = "Lifes: " + str(Scenemanager.lifes)
	if Scenemanager.lifes == 4:
		$"health_display/1".visible = false
	elif Scenemanager.lifes == 3:
		$"health_display/2".visible = false
	elif Scenemanager.lifes == 2:
		$"health_display/3".visible = false
	elif Scenemanager.lifes == 1:
		$"health_display/4".visible = false
	elif Scenemanager.lifes == 0:
		$"health_display/5".visible = false
	
	# Deathd
	if Scenemanager.lifes <= 0:
		queue_free()
	
	var rand = randf()
	
	if asteroid_spawn_rate > rand:
		spawn_astroid()


# when asteroid or character enters, loop to the other side
func _on_bounding_up_down_body_entered(body: Node2D) -> void:
	print(body.position )
	if body.position.y < 10: # upper area reached
		body.position.y = 300
	else: # lower area reached
		body.position.y = 0 
	

# when asteroid or character enters, loop to the other side
func _on_bounding_left_right_body_entered(body: Node2D) -> void:
	if body.position.x < 10: # left area reached
		body.position.x = 400
	else: # right area reached
		body.position.x = 0 

# spawning new asteroids
func spawn_astroid() -> void:
	var rand = randi_range(1,3)
	var asteroid
	
	if rand == 1: # small asteroid
		asteroid = small_asteroid.instantiate()
	elif rand == 2: # medium asteroid
		asteroid = medium_asteroid.instantiate()
	else: # big asteroid
		asteroid = big_asteroid.instantiate()
	
	add_child(asteroid)
	
	# choose random edge to spawn asteroid on
	var rand_edge = randi_range(0,3) # 0: top, 1: right, 2: down, 3: left
	
	# Get screen size
	var screen_size = get_viewport().get_visible_rect().size
	var direction
	
	
	match rand_edge:
		0: #top
			asteroid.position = Vector2(randf_range(0, screen_size.x), 0)
			direction = Vector2(0,1)
		1: #right
			asteroid.position = Vector2(screen_size.x, randf_range(0, screen_size.y))
			direction = Vector2(1,0)
		2: #down
			asteroid.position = Vector2(randf_range(0, screen_size.x), screen_size.y)
			direction = Vector2(0,-1)
		3: #left
			asteroid.position = Vector2(0, randf_range(0, screen_size.y))
			direction = Vector2(-1,0)
			
	# randomiye direction a little
	direction.y += randf_range(-0.3,0.3)
	direction.x += randf_range(-0.3,0.3)
	
	# assign direction 
	asteroid.dir = direction.normalized()
