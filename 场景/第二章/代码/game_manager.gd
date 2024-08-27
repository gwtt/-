extends Node2D

var childern:Array[Node]
var now_index = 0
var now_position:Vector2
var game_state:Array
@onready var camera_2d: Camera2D = $"../Camera2D"

func _ready():
	childern = get_children()
	#调整位置，每个图片根据分辨率放到对应的位置
	var i:float = 0
	for child in childern:
		child.position = Vector2(0,BaseSetting.get_screen_resolution().y*i)
		i = i + 1.5
	now_position = childern[0].global_position
func _process(delta: float) -> void:
	pass
