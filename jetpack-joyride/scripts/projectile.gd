extends Node2D

var damage = 10
var speed = 300

func _ready() -> void:
	# every projectile gets a random speed
	speed = randf_range(200, 400)
	# slower projectiles do more damage
	damage = round(15-(speed/100 * 2))

func _physics_process(delta: float) -> void:
	position.x -= speed*delta
	
	if position.x < -10:
		queue_free()

# if player gets hit by Projectile
# TODO maybe check if body that entered is player
func _on_area_2d_body_entered(body: Node2D) -> void:
	# subtract health from player
	Scenemanager.health -= damage
	
	# if health hits zero, death
	if Scenemanager.health <= 0:
		print("death")
	
	queue_free()
