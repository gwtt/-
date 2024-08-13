extends Sprite2D

@export var brush_size = 20

@onready var hand = $"../手区域/刮胡子的手"
@onready var world_environment = $"../WorldEnvironment"
@onready var shave = $"../刮胡子"


var cover_image:Image
var is_done = false
var count = 0
func _ready():
	cover_image = texture.get_image()
	cover_image.convert(Image.FORMAT_RGBA8)
	for x in range(cover_image.get_width()):
		for y in range(cover_image.get_height()):
			var pixel = cover_image.get_pixel(x,y)
			if pixel.a > 0:
				count += 1
	
func _input(event):
	if event is InputEventMouseMotion or event is InputEventScreenTouch:
		if event.pressure > 0:
			erase_at(hand.global_position)
			queue_redraw()

func erase_at(ps):
	if !is_pixel_opaque(to_local(ps)): 
		return
	for x in range(-brush_size,brush_size):
		for y in range(-brush_size,brush_size):
			if Vector2(x,y).length() <= brush_size:
				var px = to_local(ps) + Vector2(x,y)
				if px.x >= 0 and px.y >= 0 and px.x < cover_image.get_width() and px.y < cover_image.get_height():
						var pixel = cover_image.get_pixel(px.x,px.y)
						if pixel.a > 0:
							count -= 1
							cover_image.set_pixel(px.x,px.y,Color(0,0,0,0))
							is_draw_over()
	texture = ImageTexture.create_from_image(cover_image)

func _draw():
	draw_texture(texture,Vector2.ZERO)

#判断是否涂完,5代表可剩余量
func is_draw_over():
	if count <= 5 and !is_done:
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
