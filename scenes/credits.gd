extends Control

@onready var credits_container = $CreditsContainer
@onready var fim_do_texto = $CreditsContainer/FimDoTexto 

var speed := 40.0
var finished := false

func _process(delta):
	if finished:
		return
		
	credits_container.position.y -= speed * delta

	if fim_do_texto.global_position.y < 0:
		finished = true
		voltar_para_menu()
		
		
func voltar_para_menu():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
