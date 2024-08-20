extends GameInit

@onready var 场景: Sprite2D = $"白色框/场景"
@onready var 时钟转动: Node2D = $"时钟转动场景"
var now = 1
var png_dict = {
	1: preload("res://场景/第二章/资源/1.png"),
	2: preload("res://场景/第二章/资源/2.png"),
	3: preload("res://场景/第二章/资源/3.png"),
	4: preload("res://场景/第二章/资源/4.png"),
	5: preload("res://场景/第二章/资源/5.png"),
	6: preload("res://场景/第二章/资源/6.png"),
	7: preload("res://场景/第二章/资源/7.png"),
	8: preload("res://场景/第二章/资源/8.png"),
}
var to_last:bool = false
var now_rotation = 0
var flag:bool = false
var count = 4
func _ready() -> void:
	时钟转动.完成_两圈.connect(complete_one_circle)
	时钟转动.回退_两圈.connect(back_one_circle)
	
func _process(delta: float) -> void:
	if to_last:
		return
	now_rotation = int(时钟转动.total_rotation) % 720
	if now_rotation < 360:
		场景.self_modulate = Color(1,1,1,int(now_rotation) / 360.0)
	else:
		场景.self_modulate = Color(1,1,1,1 - int(now_rotation - 360) / 	360.0)
	
func complete_one_circle():
	if now == 8:
		return
	if now == 7 and flag == false:
		走马灯()
		flag = true
		return
	if now == 7 and count > 0 and flag == true:
		count = count - 1
		now = 0
	now = now + 1
	场景.texture = png_dict[now]
	场景.self_modulate = Color(1,1,1,0)
	if now == 8 and !to_last:
		最后场景()
	
func back_one_circle():
	if now == 1:
		return
	flag = false
	now = now - 1
	场景.texture = png_dict[now]
	场景.self_modulate = Color(1,1,1,0)

func 走马灯():
	时钟转动.able_drag = false
	时钟转动.分钟.rotation_degrees = 0.0
	场景.texture = png_dict[1]
	now = 1
	场景.self_modulate = Color(1,1,1,0)
	var tween = create_tween().set_parallel(false).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(时钟转动.分钟,"rotation_degrees",25200,10)

func 最后场景():
	to_last = true
	var tween = create_tween().set_parallel(false).set_ease(Tween.EASE_IN_OUT)
	tween.tween_interval(1)
	tween.tween_property(场景,"self_modulate",Color(1,1,1,1),1)
