extends Node2D

var childern:Array[Node]
var now_index = 1
var now_position:Vector2
var game_state:Array
@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var 背景: Sprite2D = $"../背景"

func _ready():
	GlobalGameManager.complete_game.connect(complete_game)
	childern = get_children()
	#调整位置，每个图片根据分辨率放到对应的位置
	var i:float = 0
	for child in childern:
		child.position = Vector2(0,BaseSetting.get_screen_resolution().y*i)
		i = i + 1.5
	now_position = childern[1].global_position
func _process(delta: float) -> void:
	if camera_2d.global_position.distance_to(now_position) < 15.0:
		camera_2d.limit = true
		if now_index < childern.size():
			childern[now_index]._init_game()
		camera_2d.global_position = now_position
		now_index = now_index + 1
		if now_index < childern.size():
			now_position = childern[now_index].global_position
		
func complete_game() -> void:
	camera_2d.limit = false
	move_to_next_scene()
	
func move_to_next_scene() -> void:
	var tween = create_tween().set_parallel(false).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(camera_2d,"global_position",now_position,2)


func _on_最后场景_press_button() -> void:
	背景.modulate = Color(0,0,0,1)
