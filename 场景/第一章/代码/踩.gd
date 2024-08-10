extends Sprite2D

#没有被点击
var flag = false
var origin_scale
@export var change_time = 0.3
@export var ratio = 0.2
@export var 踩图无颜色:Texture2D
@export var 踩图有颜色:Texture2D
@onready var 内容 = $"../.."

func _ready():
	origin_scale = self.scale
	内容.press_bad_signal.connect(press)

func press():
	if flag:
		var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self,"modulate",Color(1,1,1,1),change_time)
		tween.tween_property(self,"scale",origin_scale * ratio ,change_time / 2)
		await get_tree().create_timer(change_time/2).timeout
		self.set_texture(踩图无颜色)
		tween = create_tween().set_parallel(false).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self,"scale",origin_scale,change_time/2)
		flag = false
	else:
		var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self,"modulate",Color(1,1,1,1),change_time)
		tween.tween_property(self,"scale",origin_scale * ratio ,change_time / 2)
		await get_tree().create_timer(change_time/2).timeout
		self.set_texture(踩图有颜色)
		tween = create_tween().set_parallel(false).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self,"scale",origin_scale,change_time/2)
		flag = true



func _on_踩_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		内容.press_bad()
