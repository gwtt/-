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
	
