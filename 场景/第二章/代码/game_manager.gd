extends Node2D


var childern:Array[Node]




func _ready():
	childern = get_children()
	#调整位置，每个图片根据分辨率放到对应的位置
	var i = 0
	for child in childern:
		child.position = Vector2(0,BaseSetting.get_screen_resolution().y*i)
		i = i + 1
