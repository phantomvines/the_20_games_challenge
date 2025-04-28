extends StaticBody2D

var wall_speed = 300

func _process(delta: float) -> void:
	position.x -= wall_speed*delta
	
	if position.x < -60:
		queue_free()

# When player entered point area, count up
func _on_point_area_body_entered(_body: Node2D) -> void:
	Scenemanager.points += 1
	pass # Replace with function body.

# if collided with pipe, death
func _on_pipe_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("collision") #TODO Call death scene
	pass # Replace with function body.
