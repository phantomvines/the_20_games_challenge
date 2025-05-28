extends Node2D

@export var speed = 300

# initial defalut vector
var dir = Vector2(1,0)

func _physics_process(delta: float) -> void:
	position += dir*speed*delta
