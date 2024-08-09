extends Panel
@onready var canvas_layer = $"../.."
@export var offset:int = 100
@export var wait_time:float = 0.5
var origin_position
var target_position
func _ready():
	self.visible = false
func init():
	if origin_position == null:
		origin_position = self.global_position
		target_position = Vector2(origin_position.x,origin_position.y-offset)
	canvas_layer.visible = true
	self.visible = true
	self.global_position = target_position
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"global_position",origin_position,wait_time)
	tween.tween_property(self,"modulate",Color(1,1,1,1),wait_time)

func shut():
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"global_position",target_position,wait_time)
	tween.tween_property(self,"modulate",Color(1,1,1,0),wait_time)
	await get_tree().create_timer(wait_time).timeout
	self.visible = false
	canvas_layer.visible = false
