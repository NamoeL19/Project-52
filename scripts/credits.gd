extends Control

@onready var credits_container = $CreditsContainer
@onready var final_panel = $FinalPanel

var speed := 40.0
var finished := false

func _ready():
	final_panel.visible = false

func _process(delta):

	if finished:
		return

	# Faz os créditos subirem
	credits_container.position.y -= speed * delta

	# Quando sair totalmente da tela
	if credits_container.position.y < -2000:
		finished = true
		show_final_question()


func show_final_question():
	final_panel.visible = true


func _on_yes_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_no_button_pressed():
	get_tree().quit()
