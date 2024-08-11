extends Sprite2D

@export var MIN_DISTANCE_THRESHOLD = 30
var erase_points:PackedVector2Array #记录涂抹的点
var shader_material:ShaderMaterial #材质
var init_window #记录初始窗口大小
var temp
var normalized_pos
@onready var hand = $"../手区域/刮胡子的手"
@onready var beard = $"../胡子特写"
@onready var world_environment = $"../WorldEnvironment"
@onready var shave = $"../刮胡子"

var is_full = false
var is_done = false

func _ready():
	init_window = Vector2(DisplayServer.window_get_size())
	shader_material = material

func _process(delta):
	print(erase_points.size())
	temp = Vector2(DisplayServer.window_get_size())
	normalized_pos = temp / init_window
	shader_material.set_shader_parameter("scale_ratio", normalized_pos)
	if is_full and !is_done:
		is_done = true
		shave.material.set_shader_parameter("outline_color",Color(0.81,0.94,0,1))
		shave.material.set_shader_parameter("outline_width",5.0)
		world_environment.environment.set_glow_intensity(20.0)
		var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		#逐渐透明
		tween.tween_property(hand,"modulate",Color(1,1,1,0),1)
		tween.tween_property(self,"modulate",Color(1,1,1,0),1)
		await get_tree().create_timer(1).timeout
		hand.queue_free()
		self.queue_free()
		GlobalGameManager.emit_complete_game()

func _input(event):
	if event is InputEventMouseMotion or event is InputEventScreenTouch:
		if event.pressure > 0 and !is_full:
			add_erase_point(hand.global_position)
			if erase_points.size() == 17:
				is_full = true

func add_erase_point(now_position):
	var check_position = Vector2(now_position.x + init_window.x/2,now_position.y + init_window.y/2)
	if point_exists(check_position):
		return
	if is_within_allowed_area(now_position):
		now_position = Vector2(now_position.x + init_window.x/2,now_position.y + init_window.y/2)
		erase_points.append(now_position)
		shader_material.set_shader_parameter("erase_points", erase_points)
		shader_material.set_shader_parameter("erase_point_count", erase_points.size())

# 检查点是否已经存在
func point_exists(now_position):
	for point in erase_points:
		if point.distance_to(now_position) < MIN_DISTANCE_THRESHOLD:
			return true
	return false

func is_within_allowed_area(now_position):
	if self.global_position.x-150 <= now_position.x and now_position.x <= self.global_position.x+150 and self.global_position.y-50 <= now_position.y and now_position.y <= self.global_position.y+50:
		return true
	else:
		return false
