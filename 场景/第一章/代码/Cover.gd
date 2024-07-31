extends Sprite2D

@export var MIN_DISTANCE_THRESHOLD = 20
var erase_points:PackedVector2Array #记录涂抹的点
var shader_material:ShaderMaterial #材质
var init_window #记录初始窗口大小
var temp
var normalized_pos
var origin_position = Vector2(1066,614)
var real_position
@onready var hand = $"../Area2D"

func _ready():
	init_window = Vector2(DisplayServer.window_get_size())
	shader_material = material
	shader_material.set_shader_parameter("viewport_ratio", Vector2(1,1))

func _process(delta):
	temp = Vector2(DisplayServer.window_get_size())
	normalized_pos = temp / init_window
	shader_material.set_shader_parameter("scale_ratio", normalized_pos)
	
func _input(event):
	if event is InputEventMouseMotion or event is InputEventScreenTouch:
		if event.pressure > 0:
			real_position = hand.position + origin_position
			var offset = offset_position(event.global_position)
			add_erase_point(event.global_position - offset - Vector2(150,150))
			
func add_erase_point(position):
	if point_exists(position):
		return
	erase_points.append(position)
	shader_material.set_shader_parameter("erase_points", erase_points)
	shader_material.set_shader_parameter("erase_point_count", erase_points.size())
	

# 检查点是否已经存在
func point_exists(position):
	for point in erase_points:
		if point.distance_to(position) < MIN_DISTANCE_THRESHOLD:
			return true
	return false		
	
func offset_position(position):
	return position - real_position
