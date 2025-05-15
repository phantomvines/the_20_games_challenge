extends Node2D

# movement speed
@export var speed = 400

# contact damage 
var damage = 8

# angle of shot, default
var angle = Vector2(0,1)

func _ready() -> void:
	# get player node
	var player = get_tree().get_nodes_in_group("player")[0]
	# get direction the player is in
	angle = (player.global_position - global_position).normalized()

func _physics_process(delta: float) -> void:
	position += delta*speed*angle
	
	# if bullet is out of bounds, delete
	if global_position.x < -20 or global_position.x > 1200 or global_position.y < -10 or global_position.y > 1000:
		print(global_position)
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# subtract health from player
		Scenemanager.health -= damage
	
	queue_free()
