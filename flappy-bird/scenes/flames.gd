extends StaticBody2D

var wall_speed = 300

func _process(delta: float) -> void:
	position.x -= wall_speed*delta
	
	if position.x < -60:
		queue_free()


func _on_point_area_area_entered(area: Area2D) -> void:
	print("point")
	pass # Replace with function body.


func _on_point_area_body_entered(body: Node2D) -> void:
	print("point")
	pass # Replace with function body.
