extends CharacterBody2D

# for Player Movement: Falling
var gravity = 800
var movement_dir_speed = Vector2.ZERO # basically velocity that gets updated
# for Player Movement: Flapping
@export var flap_force = -300

func _physics_process(delta: float) -> void:
	# if space is pressed to flap
	if Input.is_action_just_pressed("space"):
		print("flap")
		flap()
	
	# add gravity to direction every frame -> player falling
	movement_dir_speed.y += delta*gravity
	velocity = movement_dir_speed
	move_and_slide()

func flap() -> void:
	# change direction to up and add velocity
	movement_dir_speed.y = flap_force
