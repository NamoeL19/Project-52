class_name Cannon
extends Node2D

@export var projectile_scene: PackedScene
@export var direction: Vector2 = Vector2.UP
@export var interval := 3.0

func _ready() -> void:
	var timer = $Timer
	timer.wait_time = interval
	timer.timeout.connect(_shoot)
	timer.start()

func _shoot() -> void:
	var p = projectile_scene.instantiate()
	p.direction = direction.normalized()
	p.global_position = global_position
	get_parent().add_child(p)
