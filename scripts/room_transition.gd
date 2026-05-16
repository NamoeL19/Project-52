extends Area2D

@export var direction: Utils.Direction

var active: bool = true


func _on_body_entered(body: Node2D) -> void:
	if not active or not body is Character:
		return

	var camera = get_tree().get_first_node_in_group("camera")

	if camera and not camera.is_transition:
		active = false

		# desativa detecção temporariamente
		monitoring = false

		var dir_vector = Utils.direction_to_vector(direction)
		var new_room = camera.current_room + dir_vector

		camera.start_room_transition(new_room)

		# empurra o player um pouco pra nova sala
		body.global_position += dir_vector * 16


func _on_body_exited(body: Node2D) -> void:
	if body is Character:
		active = true
		monitoring = true
