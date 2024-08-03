extends GameInit

@onready var shock = $"白色框/手机区域/手机振动"
@onready var 闹钟响声 = $"白色框/手机区域/闹钟响声"
@onready var 闹钟关闭 = $"白色框/手机区域/闹钟关闭"

func _init_game():
	闹钟响声.play()

func _on_手机区域_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			闹钟响声.stop()
			闹钟关闭.play()
			shock.stop()
			await get_tree().create_timer(1).timeout
			GlobalGameManager.emit_complete_game()
