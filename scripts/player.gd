class_name Character extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

var velocidade = 200
var can_move: bool = true
var last_direction := Vector2.DOWN
var checkpoint_manager
var is_dead := false

func _ready() -> void:
	checkpoint_manager = get_parent().get_node("CheckPointManager")

func _physics_process(delta: float) -> void:

	if !can_move:
		return

	var direction = Input.get_vector(
		"mov_left",
		"mov_right",
		"mov_up",
		"mov_down"
	)

	velocity = direction * velocidade
	move_and_slide()
	update_animation(direction)

func update_animation(direction: Vector2) -> void:
	# PLAYER ESTÁ ANDANDO
	if direction != Vector2.ZERO:
		last_direction = direction
		# MOVIMENTO LATERAL
		if abs(direction.x) > abs(direction.y):
			animated_sprite.play("walk_side")
			# OLHANDO PRA ESQUERDA
			animated_sprite.flip_h = direction.x < 0
		# MOVIMENTO PRA CIMA
		elif direction.y < 0:
			animated_sprite.play("walk_back")
			animated_sprite.flip_h = false
		# MOVIMENTO PRA BAIXO
		else:
			animated_sprite.play("walk_front")
			animated_sprite.flip_h = false

	# PLAYER PARADO
	else:
		# IDLE LATERAL
		if abs(last_direction.x) > abs(last_direction.y):
			animated_sprite.play("idle_side")
			animated_sprite.flip_h = last_direction.x < 0
		# IDLE COSTAS
		elif last_direction.y < 0:
			animated_sprite.play("idle_back")
			animated_sprite.flip_h = false
		# IDLE FRENTE
		else:
			animated_sprite.play("idle_front")
			animated_sprite.flip_h = false

func play_damage_animation() -> void:
	# SIDE
	if abs(last_direction.x) > abs(last_direction.y):
		animated_sprite.play("damage_side")
		animated_sprite.flip_h = last_direction.x < 0
	# BACK
	elif last_direction.y < 0:
		animated_sprite.play("damage_back")
		animated_sprite.flip_h = false
	# FRONT
	else:
		animated_sprite.play("damage_front")
		animated_sprite.flip_h = false

func die() -> void:
	if is_dead:
		return
	is_dead = true
	can_move = false
	velocity = Vector2.ZERO
	play_damage_animation()
	
	await get_tree().create_timer(0.15).timeout
	position = checkpoint_manager.last_location

	can_move = true
	is_dead = false
	update_animation(Vector2.ZERO)
