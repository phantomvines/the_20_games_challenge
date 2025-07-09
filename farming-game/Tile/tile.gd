extends Control

var watered: bool = false 
var tilled: bool = false
var crop_type = null
var growth_stage = 0

func _ready() -> void:
	set_animation()
	set_custom_minimum_size(Vector2(32, 32))


func set_animation() -> void:
	# set sprite of ground
	if watered:
		if tilled:
			$AnimatedSprite2D.play("tilled_watered")
		else:
			$AnimatedSprite2D.play("watered")
	else:
		if tilled:
			$AnimatedSprite2D.play("tilled_dry")
		else:
			$AnimatedSprite2D.play("dry")
		
	# set sprite of crop
	# TODO
