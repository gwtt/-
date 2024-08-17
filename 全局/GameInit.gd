class_name GameInit extends Node2D

#游戏开始前
func _init_game():
	pass

#游戏过场中
func _game_process():
	pass

#游戏销毁后
func _after_game():
	await get_tree().create_timer(BaseSetting.move_time).timeout
	self.queue_free()

#完成游戏
func complete_game():
	GlobalGameManager.emit_complete_game()

#展示场景转换按钮
func show_button():
	GlobalGameManager.emit_transition_button()
