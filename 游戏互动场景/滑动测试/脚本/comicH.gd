extends Node2D

@onready var camera_2d = $Camera2D

var isDrag = false
var StartPos = 0
var StartCamPos = 0

func _input(event):
	if event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				isDrag = true
				StartPos = event.position.x
				StartCamPos = camera_2d.position.x
			else:
				isDrag = false
				StartPos = 0
	if 	isDrag:
		var OFFSET = StartPos - event.position.x
		camera_2d.position.x = StartCamPos + OFFSET
