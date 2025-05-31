extends CharacterBody2D

# for Player Movement: Falling
var gravity = 800
var movement_dir_speed = Vector2.ZERO # basically velocity that gets updated
# for Player Movement: Boosting
@export var boost_force = -2500
# maximal upwards velocity
var max_upwards_speed = -500

# store if the color is shifted
var cshifted = false

func _physics_process(delta: float) -> void:
	
	# if space is pressed, boost upwards
	if Input.is_action_pressed("space"):
		movement_dir_speed.y += boost_force*delta
		if Scenemanager.invincible:
			$AnimatedSprite2D.play("boosting_invincible")
		else:
			$AnimatedSprite2D.play("boosting")
	else:
		if position.y >= 593:
			if Scenemanager.invincible:
				$AnimatedSprite2D.play("driving_invincible")
			else:
				$AnimatedSprite2D.play("driving")
		else:
			if Scenemanager.invincible:
				$AnimatedSprite2D.play("falling_invincible")
			else:
				$AnimatedSprite2D.play("falling")
	
	# add gravity to direction every frame -> player falling
	movement_dir_speed.y += delta*gravity
	
	# clamp upwards speed when exceeding specific value
	movement_dir_speed.y = max(movement_dir_speed.y, max_upwards_speed)
	
	velocity = movement_dir_speed
	
	# player speed does not gets changed when on floor or ceiling, does not get stuck
	if position.y < 40 or position.y > 593:
		movement_dir_speed = Vector2.ZERO
	
	move_and_slide()
