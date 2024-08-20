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
var now_rotation = 0
var flag:bool = false
func _ready() -> void:
	时钟转动.完成_两圈.connect(complete_one_circle)
	时钟转动.回退_两圈.connect(back_one_circle)
	
func _process(delta: float) -> void:
	now_rotation = int(时钟转动.total_rotation) % 720
	if now == 8 and now_rotation >= 360:
		flag = true
	if flag:
		return
	if now_rotation < 360:
		场景.self_modulate = Color(1,1,1,int(now_rotation) / 360.0)
	else:
		场景.self_modulate = Color(1,1,1,1 - int(now_rotation - 360) / 	360.0)
	
func complete_one_circle():
	if now == 8:
		return
	now = now + 1
	场景.texture = png_dict[now]
	场景.self_modulate = Color(1,1,1,0)
	
func back_one_circle():
	if now == 1:
		return
	flag = false
	now = now - 1
	场景.texture = png_dict[now]
	场景.self_modulate = Color(1,1,1,0)
