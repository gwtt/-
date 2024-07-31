extends Area2D

var isDrag = false
var OFFSET = Vector2.ZERO

func _process(delta):
	if isDrag:
		self.position = get_global_mouse_position() + OFFSET
	
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			OFFSET = self.position - get_global_mouse_position()
			isDrag = true
		else:
			isDrag = false
