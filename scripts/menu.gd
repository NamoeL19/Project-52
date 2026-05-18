extends Control

@onready var current_language = TranslationServer.get_locale()

func _ready() -> void:
	$pt_br.pressed.connect(_on_button_pressed.bind("pt_BR"))
	$en_us.pressed.connect(_on_button_pressed.bind("en_US"))
	
func _on_button_pressed(language) -> void:
	TranslationServer.set_locale(language)
	current_language = language

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/fase_1.tscn")
