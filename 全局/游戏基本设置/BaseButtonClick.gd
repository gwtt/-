class_name BaseButtonClick extends BaseButton

@export var change_position:Vector2 = Vector2(0,5)
var origin_position
func _ready():
	connect("button_up",on_button_up)
	connect("button_down",on_button_down)
	connect("mouse_entered", _on_button_mouse_enter)

func _on_button_mouse_enter():
	if !origin_position:
		origin_position = self.position
func on_button_down():
	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"position",origin_position + change_position,0.2)
	tween.tween_property(self,"modulate",Color(1,1,1,0.6),0.2)
func on_button_up():
	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"position",origin_position,0.2)
	tween.tween_property(self,"modulate",Color(1,1,1,1),0.2)
