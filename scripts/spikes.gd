extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var audio = $AudioStreamPlayer

var activated := false
var activating := false

var player_inside = null
var can_damage := true

func _ready():

	sprite.frame = 0


func activate_spike():

	if activated or activating:
		return

	activating = true

	# DELAY ANTES DE SUBIR
	await get_tree().create_timer(0.5).timeout
	
	activated = true
	audio.play()
	sprite.frame = 1


func _process(delta):

	if activated and player_inside and can_damage:

		can_damage = false

		player_inside.take_damage(1)

		await get_tree().create_timer(1.0).timeout

		can_damage = true


func _on_area_2d_body_entered(body):

	if body.is_in_group("player"):

		player_inside = body

		activate_spike()


func _on_area_2d_body_exited(body):

	if body == player_inside:

		player_inside = null
