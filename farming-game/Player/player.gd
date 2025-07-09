extends CharacterBody2D

@export var speed = 10000

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed * delta
	move_and_slide()
