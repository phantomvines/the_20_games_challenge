extends Node2D

var damage = 0.2
var speed = 300

var player_in_area = false

func _ready() -> void:
	# every area gets a speed
	#speed = randf_range(200, 400)
	# every area gets a random size
	scale = scale*randf_range(0.5,2)

func _physics_process(delta: float) -> void:
	position.x -= speed*delta
	
	# if area is off screen, delete
	if position.x < -40:
		queue_free()
		
	if player_in_area:
		Scenemanager.health -= damage
		Scenemanager.health = max(Scenemanager.health, 0)
	print(player_in_area)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = false
