extends Node2D

@onready var camera_2d = $Camera2D

var isDrag = false
var StartPos = 0
var StartCamPos = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
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

	
	pass
