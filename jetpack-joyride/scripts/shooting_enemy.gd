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
var damage = 60

func _ready() -> void:
	# randomize the movement angle
	angle = Vector2(randf_range(-0.5,0),randf_range(0.8,-0.8)).normalized()
	# randomize shooting frequency
	shooting_frequency = randf_range(0.3,1)
	
	# set timer for shooting
	$Timer.wait_time = shooting_frequency
	$Timer.start()

func _physics_process(delta: float) -> void:
	update_position(delta)
	
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
	bullet_instance.position = $shooting_point.position

# if timer timed out, shoot bullet
func _on_timer_timeout() -> void:
	shoot_bullet()
