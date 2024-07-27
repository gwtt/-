class_name BaseButtonSetting extends Button

var origin_position
var origin_scale
var is_press:bool
@export var change_position:Vector2 = Vector2(0,10)
@export var ratio: float = 1.05

func _ready():
	connect("mouse_entered", _on_button_mouse_enter)
	connect("mouse_exited", _on_button_mouse_exit)
	connect("button_up", _on_button_up)
	connect("button_down", _on_button_down)

func _on_button_mouse_enter():
	
	if !origin_position:
		origin_position = self.position
	if !origin_scale:
		origin_scale = self.scale
	var tween = create_tween().set_parallel(false).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"scale",origin_scale * ratio,0.2)

func _on_button_mouse_exit():
	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"scale",origin_scale,0.2)
	tween.tween_property(self,"position",origin_position,0.2)
func _on_button_down():
	is_press = true
	var tween = create_tween().set_parallel(false).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"position",origin_position + change_position,0.2)
	
#需要重写
func _on_button_up():
	pass
