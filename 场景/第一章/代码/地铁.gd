extends GameInit

var is_drag = false
var OFFSET = Vector2.ZERO
@onready var area_2d = $Area2D

func _process(delta):
	if is_drag:
		area_2d.global_position.y = get_global_mouse_position().y + OFFSET

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			OFFSET = area_2d.global_position.y - get_global_mouse_position().y
			is_drag = true
		else:
			is_drag = false
