class_name CutsceneText
extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var label = $ColorRect/Label

func _ready() -> void:
	color_rect.modulate.a = 0.0
	hide()

func show_text(text: String, fade_in: bool = true, text_color: Color = Color.WHITE) -> void:
	label.text = text
	label.modulate = text_color
	show()
	if fade_in:
		var tween = create_tween()
		tween.tween_property(color_rect, "modulate:a", 1.0, 1.0)
		await tween.finished
	else:
		color_rect.modulate.a = 1.0
	await get_tree().create_timer(2.0).timeout
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate:a", 0.0, 1.0)
	await tween.finished
	hide()
