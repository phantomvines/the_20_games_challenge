extends CharacterBody2D

# for Player Movement: Falling
var gravity = 800
var movement_dir_speed = Vector2.ZERO # basically velocity that gets updated
# for Player Movement: Flapping
@export var flap_force = -300

# variables for tilting of sprite
var max_down = deg_to_rad(90)
var max_up = deg_to_rad(-20)
@export var rotation_speed = 5

func _physics_process(delta: float) -> void:
	# if space is pressed to flap
	if Input.is_action_just_pressed("space"):
		print("flap")
		flap()
	
	# add gravity to direction every frame -> player falling
	movement_dir_speed.y += delta*gravity
	velocity = movement_dir_speed
	
	# maybe temporary before i find a better solution
	# if player hits ground, teleport up
	if position.y > 590:
		#position = Vector2(160, 300) # currently just teleport back to start
		#movement_dir_speed = Vector2.ZERO
		get_tree().change_scene_to_file("res://scenes/death.tscn")
	
	# player cant go above the screen, gets clamped below
	if position.y < 30:
		position.y = 30
	
	move_and_slide()
	
	 # Adjust rotation based on vertical velocity
	var target_rotation = lerp(max_up, max_down, clamp(velocity.y / 500.0, 0.0, 1.0))
	rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)
	#print(rotation)

func flap() -> void:
	# change direction to up and add velocity
	movement_dir_speed.y = flap_force
