extends GameInit

var is_drag = false
var OFFSET = Vector2.ZERO

func _process(delta):
	pass

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			OFFSET = self.global_position.y - get_global_mouse_position().y
			is_drag = true
		else:
			is_drag = false
