extends Area2D

@export var direction: Utils.Direction
@export var room_traps: Node

var active: bool = true
var first_time: bool = true  # controla se é a primeira passagem

func _on_body_entered(body: Node2D) -> void:
	if not active or not body is Character:
		return
	var camera = get_tree().get_first_node_in_group("camera")
	if camera and not camera.is_transition:
		active = false
		monitoring = false

		if first_time:
			first_time = false
			_clear_traps()

		var actual_dir_vector = _get_actual_direction(body)
		var new_room = camera.current_room + actual_dir_vector
		camera.start_room_transition(new_room)
		body.global_position += actual_dir_vector * 16

func _clear_traps() -> void:
	if room_traps:
		room_traps.queue_free() 	
	for trap in get_tree().get_nodes_in_group("traps"):
		trap.queue_free()


func _get_actual_direction(body: Node2D) -> Vector2:
	var dir_vector = Utils.direction_to_vector(direction)
	if body is CharacterBody2D:
		if body.velocity.dot(dir_vector) < 0:
			return -dir_vector
	return dir_vector

func _on_body_exited(body: Node2D) -> void:
	if body is Character:
		active = true
		monitoring = true
