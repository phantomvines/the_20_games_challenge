extends Node2D


func _ready() -> void:
	$Label.text = "Lifes: " + str(Scenemanager.lifes)

func _physics_process(delta: float) -> void:
	$Label.text = "Lifes: " + str(Scenemanager.lifes)
	
	# Deathd
	if Scenemanager.lifes <= 0:
		queue_free()

# when asteroid or character enters, loop to the other side
func _on_bounding_up_down_body_entered(body: Node2D) -> void:
	print(body.position )
	if body.position.y < 10: # upper area reached
		body.position.y = 300
	else: # lower area reached
		body.position.y = 0 
	

# when asteroid or character enters, loop to the other side
func _on_bounding_left_right_body_entered(body: Node2D) -> void:
	if body.position.x < 10: # left area reached
		body.position.x = 400
	else: # right area reached
		body.position.x = 0 
