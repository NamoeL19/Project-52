class_name SafeZone
extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body is Character:
		body.in_safezone = true
		print("seguro")

func _on_body_exited(body: Node2D) -> void:
	if body is Character:
		body.in_safezone = false
		print("cuidado, estão na maldade")
