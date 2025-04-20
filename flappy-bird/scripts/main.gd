extends Node2D

@export var flames: PackedScene = preload("res://scenes/flames.tscn")
@export var spawn_interval := 2.0  # Alle 2 Sekunden eine neue Pipe

var spawn_timer := 0.0

func _process(delta):
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0
		spawn_pipe()
		
func spawn_pipe():
	var flame_instance = flames.instantiate()
	add_child(flame_instance)
	flame_instance.position = Vector2(1200, randf_range(200, 400))  # Passe X an die Bildschirmbreite an
