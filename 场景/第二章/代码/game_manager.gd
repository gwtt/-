extends Node2D

var childern:Array[Node]
var now_index = 1
var now_position:Vector2
var game_state:Array
@onready var camera_2d: Camera2D = $"../Camera2D"

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
	if camera_2d.global_position.distance_to(now_position) < 10.0:
		camera_2d.limit = true
		camera_2d.global_position = now_position
		now_index = now_index + 1
		if now_index < childern.size():
			now_position = childern[now_index].global_position
		
func complete_game() -> void:
	camera_2d.limit = false
