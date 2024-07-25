extends Node2D

@onready var texture_progress_bar = $TextureProgressBar
@onready var animated_sprite_2d = $CharacterBody2D/AnimatedSprite2D

var isFull = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !isFull:
		texture_progress_bar.value -= 0.005

func _input(event):
	if event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				var percentage = texture_progress_bar.value+0.1
				create_tween().tween_property(texture_progress_bar,"value",percentage,0.3)
				if texture_progress_bar.value == 1:
					isFull = true
					animated_sprite_2d.play("dead")
