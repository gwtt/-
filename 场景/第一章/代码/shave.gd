extends Sprite2D

@export var brush_size = 20
@export var MIN_DISTANCE_THRESHOLD = 20

@onready var hand = $"../手区域/刮胡子的手"
@onready var world_environment = $"../WorldEnvironment"
@onready var shave = $"../刮胡子"

var erase_points:PackedVector2Array #记录涂抹的点
var cover_image:Image
var is_full = false
var is_done = false

func _ready():
	cover_image = texture.get_image()
	cover_image.convert(Image.FORMAT_RGBA8)

func _process(delta):
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
			if is_within_allowed_area(hand.global_position):
				erase_at(hand.global_position)
				queue_redraw()
				if erase_points.size() == 32:
					is_full = true

func erase_at(ps):
	if point_exists(ps): return
	for x in range(-brush_size,brush_size):
		for y in range(-brush_size,brush_size):
			if Vector2(x,y).length() <= brush_size:
				var px = to_local(ps) + Vector2(x,y)
				if px.x >= 0 and px.y >= 0 and px.x < cover_image.get_width() and px.y < cover_image.get_height():
					cover_image.set_pixel(px.x,px.y,Color(0,0,0,0))
	texture = ImageTexture.create_from_image(cover_image)
	erase_points.append(ps)

func _draw():
	draw_texture(texture,Vector2.ZERO)

func is_within_allowed_area(now_position):
	if ((self.global_position.x+868 <= now_position.x) and
		(now_position.x <= self.global_position.x+1095) or
		(self.global_position.y+809 <= now_position.y) and
		(now_position.y <= self.global_position.y+940)):
		return true
	else:
		return false

# 检查点是否已经存在
func point_exists(now_position):
	for point in erase_points:
		if point.distance_to(now_position) < MIN_DISTANCE_THRESHOLD:
			return true
	return false

