class_name DialogTrigger
extends Area2D

@export var timeline: DialogicTimeline
@export var npc: Node2D
var triggered := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if triggered or not body is Character:
		return
	triggered = true
	body.can_move = false
	Dialogic.current_state_info["speaker_node"] = npc
	Dialogic.start(timeline)
	await Dialogic.timeline_ended
	body.can_move = true
