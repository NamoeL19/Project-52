extends Area2D

var player

func _ready() -> void:
	player = get_parent().get_node("Player")


func _on_body_entered(body: Node2D) -> void:

	if body.is_in_group("player"):
		player.die()
		print("Player Morto")
