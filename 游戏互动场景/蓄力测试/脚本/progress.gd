extends Node2D

@onready var progress_bar = $TextureProgressBar
@onready var player = $CharacterBody2D/AnimatedSprite2D

var isFull = false

func _process(delta):
	if !isFull:
		progress_bar.value -= 0.005

func _input(event):
	if event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				var percentage = progress_bar.value+0.1
				create_tween().tween_property(progress_bar,"value",percentage,0.3)
				if progress_bar.value == 1:
					isFull = true
					player.play("dead")
