extends CharacterBody2D

@export var bullet: PackedScene = preload("res://player/bullet.tscn")

@export var max_speed = 15000
@export var boost_force = 10000
@export var max_rotation_speed = 2
@export var turn_force = 1

# starting vector and speed
var dir = Vector2(0, 1)
var speed = 0
var rotation_speed = 2

# for shooting cooldown checking
var s_cd = false

func _physics_process(delta: float) -> void:
	# Rotate left/right
	if Input.is_action_pressed("left"):
		dir = dir.rotated(-rotation_speed * delta)
	elif Input.is_action_pressed("right"):
		dir = dir.rotated(rotation_speed * delta)
	
	# logic for boosting
	if Input.is_action_pressed("boost"):
		speed += boost_force*delta
		speed = min(speed, max_speed)
	else:
		speed -= boost_force*delta
		speed = max(speed, 0)
	
	# logic for shooting
	if Input.is_action_pressed("shoot") and not s_cd:
		shoot()
		s_cd = true
		$shooting_cooldown.start()
	
	velocity = dir*speed*delta
	$Sprite2D.rotation = dir.angle()
	$Sprite2D.rotation_degrees += 90
	
	move_and_slide()

func shoot() -> void:
	var bullet_instance = bullet.instantiate()
	add_child(bullet_instance)
	bullet_instance.position = $shooting_position.position
	bullet_instance.dir = dir


func _on_shooting_cooldown_timeout() -> void:
	s_cd = false
