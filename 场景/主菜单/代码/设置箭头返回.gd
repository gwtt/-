extends TextureButton
#开始界面
@export var start_panel:Control
#自己在的panel
@export var own_panel:Control
@export var change_position:Vector2 = Vector2(0,5)
var origin_position
func _ready():
	own_panel.visible = false
	own_panel.modulate = Color(1,1,1,0)
	connect("button_up",back_to_main_menu)
	connect("button_down",on_button_down)
	connect("mouse_entered", _on_button_mouse_enter)

func _on_button_mouse_enter():
	if !origin_position:
		origin_position = self.position
func on_button_down():
	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"position",origin_position + change_position,0.2)
	tween.tween_property(self,"modulate",Color(1,1,1,0.5),0.2)
func back_to_main_menu():
	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(own_panel,"modulate",Color(1,1,1,0),0.2)
	tween.tween_property(start_panel,"modulate",Color(1,1,1,1),0.2)
	tween.tween_property(own_panel,"visible",false,0.2)
	tween.tween_property(start_panel,"visible",true,0.2)
	tween.tween_property(self,"modulate",Color(1,1,1,1),0.2)
