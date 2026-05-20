class_name Character extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var sound_damage = $AudioStreamPlayer

var velocidade = 200
var can_move: bool = true
var last_direction := Vector2.DOWN

var checkpoint_manager
var in_safezone := false
var is_dead := false
var is_taking_damage := false

# VIDA
var max_health := 3
var health := 3
var invulnerable := false


func _ready() -> void:

	checkpoint_manager = get_parent().get_node("CheckPointManager")
	health = max_health
	print(health)


func _physics_process(delta: float) -> void:

	if !can_move or is_taking_damage:
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

	# PLAYER ANDANDO
	if direction != Vector2.ZERO:

		last_direction = direction

		# MOVIMENTO LATERAL
		if abs(direction.x) > abs(direction.y):

			animated_sprite.play("walk_side")

			animated_sprite.flip_h = direction.x < 0

		# MOVIMENTO PRA CIMA
		elif direction.y < 0:

			animated_sprite.play("walk_back")

			animated_sprite.flip_h = false

		# MOVIMENTO PRA BAIXO
		else:

			animated_sprite.play("walk_front")

			animated_sprite.flip_h = false

	#PLAYER PARADO
	else:

		#IDLE LATERAL
		if abs(last_direction.x) > abs(last_direction.y):

			animated_sprite.play("idle_side")

			animated_sprite.flip_h = last_direction.x < 0

		#IDLE COSTAS
		elif last_direction.y < 0:

			animated_sprite.play("idle_back")

			animated_sprite.flip_h = false
		
		#IDLE FRENTE
		else:
			animated_sprite.play("idle_front")
			animated_sprite.flip_h = false


func play_damage_animation() -> void:

	# DAMAGE SIDE
	if abs(last_direction.x) > abs(last_direction.y):

		animated_sprite.play("damage_side")

		animated_sprite.flip_h = last_direction.x < 0

	# DAMAGE BACK
	elif last_direction.y < 0:

		animated_sprite.play("damage_back")

		animated_sprite.flip_h = false

	# DAMAGE FRONT
	else:

		animated_sprite.play("damage_front")

		animated_sprite.flip_h = false


func take_damage(amount := 1) -> void:

	if invulnerable or is_dead:
		return

	invulnerable = true
	is_taking_damage = true

	health -= amount
	sound_damage.play()
	print("Vida atual: ", health)

	velocity = Vector2.ZERO

	play_damage_animation()

	# MORTE
	if health <= 0:

		die()

		return

	# TEMPO DA ANIMAÇÃO DE DANO
	await get_tree().create_timer(0.3).timeout

	is_taking_damage = false

	update_animation(Vector2.ZERO)

	# TEMPO DE INVENCIBILIDADE
	await get_tree().create_timer(0.7).timeout

	invulnerable = false


func die() -> void:
	if is_dead:
		return
	is_dead = true
	can_move = false
	velocity = Vector2.ZERO
	animated_sprite.play("die")  # toca a animação
	await animated_sprite.animation_finished  # espera terminar
	position = checkpoint_manager.last_location
	health = max_health
	can_move = true
	is_dead = false
	is_taking_damage = false
	invulnerable = false
	update_animation(Vector2.ZERO)
