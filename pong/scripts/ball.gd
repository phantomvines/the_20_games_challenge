extends Area2D

# ball speed and initial velocity
@export var ball_speed = 100
var ball_dir = Vector2(1,2).normalized()

# for speeding up the ball
var time_elapsed = 0

# Emmission length of particles
var emission_length = 0.1

signal ball_hit(side: String)

func _process(delta: float) -> void:
	# move ball in direction
	time_elapsed += delta
	position += ball_dir * (ball_speed+time_elapsed) * delta
	#print(time_elapsed)

func _on_body_entered(body: Node2D) -> void:
	# Bounce off of Player
	if body.is_in_group("players"):
		ball_dir.x *= -1
		$CPUParticles2D.emitting = true # emit particles
		$Timer.wait_time = emission_length
		$Timer.start()
	
	# Bounce off of Top and Bottom
	if body.is_in_group("bounding_box"):
		ball_dir.y *= -1
		$CPUParticles2D.emitting = true # emit particles
		$Timer.wait_time = emission_length
		$Timer.start()
		
	# ball hits left hit area, teleported to middle
	if body.is_in_group("left_hit_area"):
		print("left")
		position = Vector2(200, 150)
		ball_dir = Vector2(1,2).normalized()
		ball_hit.emit("left")
	
	# ball hits right hit area, teleported to middle
	if body.is_in_group("right_hit_area"):
		print("right")
		position = Vector2(200, 150)
		ball_dir = Vector2(1,2).normalized()
		ball_hit.emit("right")

func _ready() -> void:
	$CPUParticles2D.emitting = false

func _on_timer_timeout() -> void:
	# stop emitting particles
	$CPUParticles2D.emitting = false
