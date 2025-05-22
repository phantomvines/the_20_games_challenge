extends Node2D

# prelaod bullet scene
@export var bullet: PackedScene = preload("res://scenes/bullet.tscn")

# movement speed
@export var speed = 300
# frequency at which bullets are shot
@export var shooting_frequency = 10

# default movement angle
var angle = Vector2(-0.7,-1)

# contact damage 
var damage = 30

func _ready() -> void:
	# randomize the movement angle
	#angle = Vector2(randf_range(-0.5,0),randf_range(0.8,-0.8)).normalized()
	# Always move to the left, with vertical angle between -45 and 45 degrees
	var angle_degrees = randf_range(-45.0, 45.0)
	var angle_radians = deg_to_rad(angle_degrees)
	angle = Vector2(cos(angle_radians), sin(angle_radians)).normalized()
	
	angle.x = abs(angle.x)*-1
	
	$AnimatedSprite2D.play("default")


	# randomize shooting frequency
	shooting_frequency = randf_range(0.8,1)
	
	# set timer for shooting
	$Timer.wait_time = shooting_frequency
	$Timer.start()

func _physics_process(delta: float) -> void:
	update_position(delta)
	
	# delete if out of bounds
	if position.x < -10:
		queue_free()

# correct movement
func update_position(delta: float) -> void:
	position += angle*speed*delta
	# hit top or bottom, reflect
	if position.y < 40 or position.y > 600:
		angle.y = angle.y*-1

# spawn a bullet
func shoot_bullet() -> void:
	var bullet_instance = bullet.instantiate()
	add_child(bullet_instance)
	# add bullet as a child the the global scene tree, so that movement is not dependend on enemy
	#get_tree().current_scene.add_child(bullet_instance)
	#bullet_instance.global_position = $shooting_point.global_position

	bullet_instance.position = $shooting_point.position

# if timer timed out, shoot bullet
func _on_timer_timeout() -> void:
	shoot_bullet()


func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# subtract health from player
		Scenemanager.health -= damage
	
	queue_free()
