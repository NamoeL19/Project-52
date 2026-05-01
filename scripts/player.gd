extends CharacterBody2D

var velocidade = 350

func _process(delta: float) -> void:
	var direction = Input.get_vector("mov_left", "mov_right", "mov_up", "mov_down")
	
	velocity = direction * velocidade
	move_and_slide()
	print(direction)
