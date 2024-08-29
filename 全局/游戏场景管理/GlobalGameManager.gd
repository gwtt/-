extends Node

signal complete_game
#需要转场按钮显示
signal transition_button
signal back_to_menu
signal turn_to_next
func emit_complete_game():
	print("完成游戏")
	emit_signal("complete_game")

func emit_transition_button():
	emit_signal("transition_button")

func emit_back_to_menu():
	emit_signal("back_to_menu")

func emit_turn_to_next():
	emit_signal("turn_to_next")

func log_message(node_name,call:Callable):
	print(node_name + "调用了" + call.get_method())
	call.call()
	
func log_custom_message(message):
	print(message)
