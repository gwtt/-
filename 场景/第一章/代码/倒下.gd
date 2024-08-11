extends GameInit

@onready var 主角 = $"白色框/主角"

var flag = false

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed() and !flag:
			主角.play("倒下")
			flag = true


func _on_手机区域_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed() and flag:
			#防止多次点击
			flag = false
			GlobalGameManager.emit_complete_game()
