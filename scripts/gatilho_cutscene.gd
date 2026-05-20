class_name CutsceneTrigger
extends Area2D

@export var text: String
@export var cutscene: CutsceneText
@export var fade_in: bool = true
@export var text_color: Color = Color.WHITE
var triggered := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	call_deferred("_check_overlap")

func _check_overlap() -> void:
	for body in get_overlapping_bodies():
		_on_body_entered(body)

func _on_body_entered(body: Node2D) -> void:
	if triggered or not body is Character:
		return
	triggered = true
	body.can_move = false
	await cutscene.show_text(text, fade_in, text_color)
	body.can_move = true
