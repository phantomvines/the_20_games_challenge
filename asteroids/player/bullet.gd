extends Node2D

@export var speed = 300

# initial defalut vector
var dir = Vector2(1,0)

func _ready() -> void:
	$lifetime.start()
	add_to_group("player_bullet")

func _physics_process(delta: float) -> void:
	position += dir*speed*delta


func _on_lifetime_timeout() -> void:
	queue_free()

# if something got hit
func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()
