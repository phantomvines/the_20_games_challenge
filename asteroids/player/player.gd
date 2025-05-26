extends CharacterBody2D

@export var max_speed = 15000
@export var boost_force = 10000
@export var max_rotation_speed = 2
@export var turn_force = 1


# starting vector and speed
var dir = Vector2(0, 1)
var speed = 0
var rotation_speed = 1

func _physics_process(delta: float) -> void:
	# Rotate left/right
	if Input.is_action_pressed("left"):
		dir = dir.rotated(-rotation_speed * delta)
		print("left")
	elif Input.is_action_pressed("right"):
		dir = dir.rotated(rotation_speed * delta)
	
	# logic for boosting
	if Input.is_action_pressed("boost"):
		speed += boost_force*delta
		speed = min(speed, max_speed)
	else:
		speed -= boost_force*delta
		speed = max(speed, 0)
	
	# logic for rotating
#	if Input.is_action_pressed("left"):
#		dir.angle()

	
	print(dir)
	
	velocity = dir*speed*delta
	$Sprite2D.rotation = dir.angle()
	$Sprite2D.rotation_degrees += 90
	
	move_and_slide()
