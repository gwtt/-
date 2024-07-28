extends TextureButton

@onready var start_panel = $"../../../../../初始界面"
@onready var setting_panel = $"../../../.."
@export var change_position:Vector2 = Vector2(0,5)
var origin_position
func _ready():
	setting_panel.modulate = Color(1,1,1,0)
	setting_panel.mouse_filter = MOUSE_FILTER_IGNORE
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
	setting_panel.visible = false
	start_panel.visible = true
	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(setting_panel,"modulate",Color(1,1,1,0),0.2)
	tween.tween_property(start_panel,"modulate",Color(1,1,1,1),0.2)
	tween.tween_property(self,"modulate",Color(1,1,1,1),0.2)
