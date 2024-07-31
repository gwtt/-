extends Area2D

@onready var shock = $"手机振动"
@onready var mobilephone = $"../手机"

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			await get_tree().create_timer(1).timeout
			shock.stop()
			await get_tree().create_timer(1).timeout
			GlobalGameManager.emit_complete_game()
