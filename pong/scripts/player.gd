extends CharacterBody2D

# for different sprites and movement
@export var is_player_1 = true
# player speed for adjustment
@export var player_speed = 2000

func _ready() -> void:
	# check if player 1 or 2 to set right sprite
	if is_player_1:
		$sprite_player2.visible = false
	else:
		$sprite_player1.visible = false

func _physics_process(delta: float) -> void:
	# movement of the players
	var direction
	if is_player_1:
		direction = Input.get_axis("left_up", "left_down")
	else:
		direction = Input.get_axis("right_up", "right_down")
	velocity = Vector2(0, direction * player_speed * delta)
	move_and_slide()
