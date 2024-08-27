extends Camera2D

var is_drag = false
var StartPos = 0
var StartCamPos = 0
var limit_y
var OFFSET = 0
func _ready() -> void:
	limit_y = self.global_position.y

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_mask == MOUSE_BUTTON_LEFT and event.is_pressed():
			is_drag = true
			StartPos = event.position.y
			StartCamPos = self.position.y
		else:
			is_drag = false
			StartPos = 0
	if 	is_drag:
		var OFFSET = event.position.y - StartPos
		#做一个限制，不能超过一个区域
		if StartCamPos - OFFSET > limit_y:
			self.position.y = StartCamPos - OFFSET
