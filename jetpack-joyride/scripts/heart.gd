extends Node2D

# amount the heart heals when collected
var heal_amount = 30
var speed = 300

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _physics_process(delta: float) -> void:
	position.x -= speed*delta
	
	if position.x < -10:
		queue_free()

# if player gets hit by Projectile
# TODO maybe check if body that entered is player
func _on_area_2d_body_entered(body: Node2D) -> void:
	# heal player 
	if body.is_in_group("player"):
		# subtract health from player
		Scenemanager.health += heal_amount
		# health caps at 100
		Scenemanager.health = min(Scenemanager.health, 100)
	
	queue_free()
