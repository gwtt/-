extends Area2D

var is_drag = false
var OFFSET = Vector2.ZERO
@onready var hand = $"刮胡子的手"

func _process(delta):
	if is_drag:
		self.position = get_global_mouse_position() + OFFSET
	
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			OFFSET = self.global_position - get_global_mouse_position()
			is_drag = true
		else:
			is_drag = false
