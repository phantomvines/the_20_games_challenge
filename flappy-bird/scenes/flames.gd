extends StaticBody2D

var wall_speed = 300

func _process(delta: float) -> void:
	position.x -= wall_speed*delta
	
	if position.x < -60:
		queue_free()
