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
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is StaticBody2D:
			print("Collided with static body!")
	
	move_and_slide()

func flap() -> void:
	# change direction to up and add velocity
	movement_dir_speed.y = flap_force

func _on_floor_area_entered(area: Area2D) -> void:
	# TODO Death
	print("floor hit")
	position = Vector2(160, 340) # currently just teleport back to start
	velocity = Vector2.ZERO
