extends Node

signal complete_game

func emit_complete_game():
	emit_signal("complete_game")
