extends GameInit

@onready var shock = $"白色框/手机区域/手机振动"
@onready var 闹钟响声 = $"白色框/手机区域/闹钟响声"
@onready var 闹钟关闭 = $"白色框/手机区域/闹钟关闭"
var is_over = false
func _init_game():
	闹钟响声.play()

func _on_手机区域_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed() and !is_over:
			is_over = true
			闹钟响声.stop()
			闹钟关闭.play()
			shock.stop()
			await get_tree().create_timer(BaseSetting.move_time).timeout
			GlobalGameManager.emit_complete_game()
