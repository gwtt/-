extends GameInit

@onready var 简历 = $"白色框/简历"
var is_drag = false
#表示是否结束
var is_over = false
#是否在位置上
var is_on_positon
var OFFSET = Vector2.ZERO

func _process(delta):
	if is_drag and !is_over:
		简历.global_position = get_global_mouse_position() + OFFSET
		
func _on_area_2d_area_entered(area):
	is_drag = true
	is_over = true
	GlobalGameManager.emit_complete_game()


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			OFFSET = 简历.global_position - get_global_mouse_position()
			is_drag = true
		else:
			is_drag = false
