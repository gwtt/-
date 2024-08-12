extends Sprite2D
@export var brush_size = 30

var cover_image:Image


func _ready():
	cover_image = texture.get_image()
	cover_image.convert(Image.FORMAT_RGBA8)



func _input(event):
	if event is InputEventMouseMotion or event is InputEventScreenTouch:
		if event.pressure > 0:
			erase_at(event.position)
			queue_redraw()

func erase_at(ps):
	for x in range(-brush_size,brush_size):
		for y in range(-brush_size,brush_size):
			if Vector2(x,y).length() <= brush_size:
				var px = to_local(ps) + Vector2(x,y)
				if px.x >= 0 and px.y >= 0 and px.x < cover_image.get_width() and px.y < cover_image.get_height():
					cover_image.set_pixel(px.x,px.y,Color(0,0,0,0))
	texture = ImageTexture.create_from_image(cover_image)
func _draw():
	draw_texture(texture,Vector2.ZERO)
