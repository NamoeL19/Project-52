extends Camera2D

@export var smoothing_enable: bool = true
@export var smoothing_speed: float = 5.0

const ROOM_WIDTH: int = 496
const ROOM_HEIGHT: int = 496
const TRANSITION_DURATION: float = 0.25

var current_room: Vector2 = Vector2.ZERO
var target_position: Vector2 = Vector2.ZERO
var is_transition: bool = false
var player: Character = null
var transition_tween: Tween

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

	current_room = Vector2.ZERO

	global_position = Vector2(
		current_room.x * ROOM_WIDTH + ROOM_WIDTH / 2,
		current_room.y * ROOM_HEIGHT + ROOM_HEIGHT / 2
	)

	update_limits()

	position_smoothing_enabled = smoothing_enable
	position_smoothing_speed = smoothing_speed


func start_room_transition(room_coord: Vector2):
	if is_transition:
		return

	current_room = room_coord

	position_smoothing_enabled = false

	# libera limites durante transição
	limit_left = -10000000
	limit_right = 10000000
	limit_top = -10000000
	limit_bottom = 10000000

	if player:
		player.can_move = false
		player.velocity = Vector2.ZERO

	is_transition = true

	target_position = Vector2(
		current_room.x * ROOM_WIDTH + ROOM_WIDTH / 2,
		current_room.y * ROOM_HEIGHT + ROOM_HEIGHT / 2
	)

	if transition_tween:
		transition_tween.kill()

	transition_tween = create_tween()
	transition_tween.set_trans(Tween.TRANS_SINE)
	transition_tween.set_ease(Tween.EASE_IN_OUT)

	transition_tween.tween_property(
		self,
		"global_position",
		target_position,
		TRANSITION_DURATION
	)

	transition_tween.tween_callback(finisht_transition)


func finisht_transition():
	position_smoothing_enabled = smoothing_enable
	position_smoothing_speed = smoothing_speed

	update_limits()

	is_transition = false

	if player:
		player.can_move = true


func update_limits():
	limit_left = current_room.x * ROOM_WIDTH
	limit_right = limit_left + ROOM_WIDTH

	limit_top = current_room.y * ROOM_HEIGHT
	limit_bottom = limit_top + ROOM_HEIGHT
