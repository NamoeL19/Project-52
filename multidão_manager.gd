class_name CrowdManager
extends Node

@export var crowd_scene: PackedScene
@export var spawn_point: Node2D  # arrasta o ponto de spawn no editor

var crowd_instance: Crowd = null
var cleared := false  # multidão não volta depois que sala foi limpa
var wave := 0
# intervalos: 5s, 10s, 20s, 40s...
var intervals := [5.0, 10.0, 20.0, 40.0]

func _ready() -> void:
	start_next_wave()

func start_next_wave() -> void:
	if cleared:
		return
	var wait_time = intervals[min(wave, intervals.size() - 1)]
	await get_tree().create_timer(wait_time).timeout
	if cleared:
		return
	spawn_crowd()

func spawn_crowd() -> void:
	if cleared or crowd_instance != null:
		return
	crowd_instance = crowd_scene.instantiate()
	crowd_instance.global_position = spawn_point.global_position
	crowd_instance.crowd_finished.connect(_on_crowd_finished)
	add_child(crowd_instance)

func dismiss_crowd() -> void:
	if crowd_instance:
		crowd_instance.queue_free()
		crowd_instance = null

func clear_room() -> void:
	cleared = true
	dismiss_crowd()

func _on_crowd_finished() -> void:
	crowd_instance = null
	wave += 1
	start_next_wave()
