class_name BaseButtonMovetoNotClick extends BaseButton
#为的就是点击然后移出，不触发点击效果
var is_press:bool
@export var ratio:float=1.0
@export var wait_time:float = 1.0
var origin_scale
func _ready():
	connect("mouse_entered", _on_button_mouse_enter)
	connect("mouse_exited", _on_button_mouse_exit)
	connect("button_up", _on_button_up)
	connect("button_down", _on_button_down)
	origin_scale = self.scale

func _on_button_mouse_enter():
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"scale",origin_scale*ratio,wait_time)
	pass

func _on_button_mouse_exit():
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"scale",origin_scale,wait_time)
	is_press = false


func _on_button_down():
	is_press = true


func _on_button_up():
	is_press = false
