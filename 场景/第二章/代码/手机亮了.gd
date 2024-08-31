extends GameInit


func _init_game():
	await get_tree().create_timer(1).timeout
	GlobalGameManager.emit_complete_game()
