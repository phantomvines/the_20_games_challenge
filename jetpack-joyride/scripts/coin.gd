extends Node2D

var speed = 300

func _ready() -> void:
	# every projectile gets a random speed
	speed = 200
	$AnimatedSprite2D.play("default")

func _physics_process(delta: float) -> void:
	position.x -= speed*delta
	
	if position.x < -10:
		queue_free()

# if player gets hit by Projectile
# TODO maybe check if body that entered is player
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# subtract health from player
		Scenemanager.score += 1
	
	queue_free()
