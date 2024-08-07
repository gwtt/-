class_name BaseButtonStart extends BaseButtonMovetoNotClick
#开始界面的按钮
var origin_position
@export var change_position:Vector2 = Vector2(30,0)
#选择哪个页面切换
@export var target_node:Control
#初始界面
@onready var start_panel = $"../../.."
func _on_button_mouse_enter():
	if !origin_position:
		origin_position = self.position
	if !is_press:
		var tween = create_tween().set_parallel(false).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self,"position",origin_position - change_position,0.2)

func _on_button_mouse_exit():
	super()
	var tween = create_tween().set_parallel(false).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"position",origin_position,0.4)

func _on_button_down():
	super()
	var tween = create_tween().set_parallel(false).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"position",origin_position + change_position,0.2)
	
#切换场景
func _on_button_up():
	self.position = origin_position
	if target_node:
		if is_press:
			var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_OUT)
			tween.tween_property(start_panel,"modulate",Color(1, 1, 1, 0),0.2)
			tween.tween_property(target_node,"modulate",Color(1, 1, 1, 1),0.2)
			tween.tween_property(start_panel,"visible",false,0.2)
			tween.tween_property(target_node,"visible",true,0.2)
	super()
