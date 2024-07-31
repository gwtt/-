extends Sprite2D

@export var MIN_DISTANCE_THRESHOLD = 20
var erase_points:PackedVector2Array #记录涂抹的点
var shader_material:ShaderMaterial #材质
var init_window #记录初始窗口大小
var temp
var normalized_pos
@onready var hand = $"../手区域/刮胡子的手"
var is_full = false

func _ready():
	init_window = Vector2(DisplayServer.window_get_size())
	shader_material = material
	shader_material.set_shader_parameter("viewport_ratio", Vector2(1,1))

func _process(delta):
	temp = Vector2(DisplayServer.window_get_size())
	normalized_pos = temp / init_window
	shader_material.set_shader_parameter("scale_ratio", normalized_pos)
	if is_full:
		#逐渐透明
		create_tween().tween_property(hand,"modulate",Color(1,1,1,0),1)
		await get_tree().create_timer(2).timeout
		hand.queue_free()
		self.queue_free()
		GlobalGameManager.emit_complete_game()

func _input(event):
	if event is InputEventMouseMotion or event is InputEventScreenTouch:
		if event.pressure > 0 and !is_full:
			add_erase_point(hand.global_position)
			if erase_points.size() == 31:
				is_full = true

func add_erase_point(position):
	if point_exists(position):
		return
	if is_within_allowed_area(position):
		erase_points.append(position)
		shader_material.set_shader_parameter("erase_points", erase_points)
		shader_material.set_shader_parameter("erase_point_count", erase_points.size())

# 检查点是否已经存在
func point_exists(position):
	for point in erase_points:
		if point.distance_to(position) < MIN_DISTANCE_THRESHOLD:
			return true
	return false

func is_within_allowed_area(position):
	if self.global_position.x-150 <= position.x and position.x <= self.global_position.x+150 and self.global_position.y-50 <= position.y and position.y <= self.global_position.y+50:
		return true
	else:
		return false
