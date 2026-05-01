extends Node2D

func _ready():
	var camera = $Player/Camera2D

	var left = $TopLeft.position.x
	var top = $TopLeft.position.y
	var right = $BottomRight.position.x
	var bottom = $BottomRight.position.y

	camera.limit_left = left
	camera.limit_top = top
	camera.limit_right = right
	camera.limit_bottom = bottom

	#AREA PARA LIMITAR O PLAYER, PARA NÃO SAIR DA AREA DO MAPA
	create_wall(Vector2((left + right)/2, top - 16), Vector2(right - left, 32))
	create_wall(Vector2((left + right)/2, bottom + 16), Vector2(right - left, 32))
	create_wall(Vector2(left - 16, (top + bottom)/2), Vector2(32, bottom - top))
	create_wall(Vector2(right + 16, (top + bottom)/2), Vector2(32, bottom - top))

#FUNÇÃO QUE FAZ ISSO
func create_wall(pos, size):
	var wall = StaticBody2D.new()
	var col = CollisionShape2D.new()
	var shape = RectangleShape2D.new()

	shape.size = size
	col.shape = shape

	wall.add_child(col)
	wall.position = pos

	add_child(wall)
