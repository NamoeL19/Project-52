extends Node2D

@export var cutscene: CutsceneText
@export var credits_scene: String = "res://scenes/credits.tscn"

func _ready() -> void:
	await get_tree().create_timer(30).timeout
	_fade_to_credits()

func _fade_to_credits() -> void:
	# usa o ColorRect do CutsceneText pra fazer o fade
	cutscene.show()
	var tween = create_tween()
	tween.tween_property(cutscene.color_rect, "modulate:a", 1.0, 1.0)
	await tween.finished
	get_tree().change_scene_to_file(credits_scene)
