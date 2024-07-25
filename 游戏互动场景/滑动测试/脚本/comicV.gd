extends Node2D

@onready var camera_2d = $Camera2D

var isDrag = false
var StartPos = 0
var StartCamPos = 0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				isDrag = true
				StartPos = event.position.y
				StartCamPos = camera_2d.position.y
			else:
				isDrag = false
				StartPos = 0
	if 	isDrag:
		var OFFSET = StartPos - event.position.y
		camera_2d.position.y = StartCamPos + OFFSET
	pass
