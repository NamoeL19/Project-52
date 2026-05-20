class_name Projectile
extends Area2D

@export var speed := 200.0
@export var max_distance := 500.0
var direction := Vector2.UP
var distance_traveled := 0.0
var active := false

func _ready() -> void:
	monitoring = false
	body_entered.connect(_on_body_entered)
	# ativa colisão só depois de 2 frames
	await get_tree().process_frame
	await get_tree().process_frame
	monitoring = true
	active = true

func _physics_process(delta: float) -> void:
	if not active:
		return
	var move = direction * speed * delta
	global_position += move
	distance_traveled += move.length()
	if distance_traveled >= max_distance:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage()
	queue_free()
