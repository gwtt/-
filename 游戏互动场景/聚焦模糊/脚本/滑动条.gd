extends Sprite2D

var zoom_in_factor := 0.0
var flag = false
@onready var picture = $"../图片"

func _process(delta):
	if get_rect().has_point(to_local(get_global_mouse_position())):
		flag = true
	else:
		flag = false
	if flag == false:
		return
	if Input.is_action_just_pressed("zoom_in"):
		zoom_in_factor += 0.05
	elif Input.is_action_just_pressed("zoom_out"):	
		zoom_in_factor -= 0.05
	if zoom_in_factor > 1:
		zoom_in_factor -= 1
	if zoom_in_factor < -1:
		zoom_in_factor += 1
	picture.material.set_shader_parameter("uv_x",zoom_in_factor)
	picture.material.set_shader_parameter("_Radius",zoom_in_factor * 5)
