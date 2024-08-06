extends Node

signal complete_game
#需要转场按钮显示
signal transition_button
func emit_complete_game():
	emit_signal("complete_game")

func emit_transition_button():
	emit_signal("transition_button")
