extends Node2D

var now_index=0
var now_node:Node
var next_node:Node
var current_position:Vector2 = Vector2(0,0)
#离去的位置
var move_postion:Vector2
var childern:Array[Node]
#离去时间
var move_time:float = 1.0
var origin_time:float = 1.0
@onready var ____ = $"../菜单按钮"


func _ready():
	move_time = BaseSetting.move_time
	origin_time = BaseSetting.origin_time
	childern = get_children()
	#调整位置，每个图片根据分辨率放到对应的位置
	var i = 0
	for child in childern:
		child.position = Vector2(BaseSetting.get_screen_resolution().x*i,0)
		i = i + 1
	GlobalGameManager.complete_game.connect(change_node)
	move_postion = Vector2(-BaseSetting.get_screen_resolution().x,0)
	
func change_node():
	var temp = now_index + 2
	while temp < childern.size():
		childern[temp].position = Vector2(childern[temp].position.x - BaseSetting.get_screen_resolution().x,0)
		temp = temp + 1
	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_OUT)
	if childern[now_index+1].is_in_group("转场") or childern[now_index].is_in_group("转场"):
		tween.set_trans(Tween.TRANS_LINEAR)
	else:
		tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(childern[now_index],"position",move_postion,move_time)
	now_index=now_index+1
	tween.tween_property(childern[now_index],"position",current_position,move_time)
	if now_index >= 1:
		childern[now_index-1]._after_game()
	childern[now_index]._init_game()
	if childern[now_index].is_in_group("转场"):
		await get_tree().create_timer(move_time).timeout
		GlobalGameManager.emit_complete_game()
	if childern[now_index].is_in_group("面试"):
		await get_tree().create_timer(move_time * 2).timeout
		GlobalGameManager.emit_complete_game()
	if childern[now_index].is_in_group("需要按钮场景"):
		await get_tree().create_timer(move_time).timeout
		GlobalGameManager.emit_transition_button()


