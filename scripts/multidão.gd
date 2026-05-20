class_name Crowd
extends CharacterBody2D

@export var speed := 80.0
@onready var nav_agent = $NavigationAgent2D
var player: Character

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	# pequeno delay pra navegação inicializar antes de calcular o path
	await get_tree().create_timer(0.2).timeout
	set_movement_target()

signal crowd_finished

func _physics_process(delta: float) -> void:
	if nav_agent.is_navigation_finished():
		crowd_finished.emit()  # avisa o manager que chegou
		return
		
	var next_point = nav_agent.get_next_path_position()
	velocity = (next_point - global_position).normalized() * speed
	move_and_slide()

func set_movement_target() -> void:
	if player:
		nav_agent.set_target_position(player.global_position)

func _on_body_entered(body: Node2D) -> void:
	if body is Character and not body.in_safezone:
		body.die()
