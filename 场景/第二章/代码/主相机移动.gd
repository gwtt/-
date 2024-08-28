extends Camera2D
@onready var area_2d: Area2D = $Area2D

var is_drag = false
var StartPos = 0
var StartCamPos = 0
var limit_y
var OFFSET = 0
var limit = false:
	set(value):
		if value:
			area_2d.visible = false
		else:
			area_2d.visible = true
			limit_y = self.global_position.y
		is_drag = false
		limit = value

func _ready() -> void:
	limit_y = self.global_position.y
	
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and !limit:
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
