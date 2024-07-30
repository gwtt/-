extends Camera2D

var isDrag = false
var StartPos = 0
var StartCamPos = 0

func _input(event):
	if event is InputEventMouseMotion or event is InputEventScreenTouch:
		if event.pressure > 0:
			if !isDrag:
				isDrag = true
				StartPos = event.position.x
				StartCamPos = position.x
			else:
				var OFFSET = StartPos - event.position.x
				position.x = StartCamPos + OFFSET
		else:
			isDrag = false	
