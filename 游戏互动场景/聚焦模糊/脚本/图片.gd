extends Sprite2D

func _process(delta):
	var shader_material = material
	shader_material.set_shader_parameter("focus_point", get_global_mouse_position() / Vector2(get_viewport().size))
