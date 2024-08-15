extends GameInit

var flag = false

func _on_手机区域_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed() and !flag:
			flag = true
			GlobalGameManager.emit_complete_game()
