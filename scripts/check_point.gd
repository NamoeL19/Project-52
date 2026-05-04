extends Area2D

var checkpoint_manager

func _ready() -> void:
	checkpoint_manager = get_parent().get_parent().get_node("CheckPointManager")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		checkpoint_manager.last_location = $RespawnPoint.global_position
		print("Checkpoint Setado")
