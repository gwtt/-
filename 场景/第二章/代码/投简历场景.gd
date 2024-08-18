extends Node2D

var move_time:float = 1
var right_scale = Vector2(0.236,-0.161)
var count = 0

@onready var origin: Node2D = $"初始位置"
@onready var display: Node2D = $"显示位置"
@onready var content: Node2D = $"Mask/投递内容"
@onready var disappear_pass: Node2D = $"消失位置_投递"
@onready var disappear_post: Node2D = $"消失位置_跳过"
@onready var mask: Sprite2D = $Mask

var content_init
const content_scene = preload("res://场景/第二章/场景/投递内容.tscn")

func create_node():
	content_init = content_scene.instantiate()
	mask.add_child(content_init)
	content_init.set_scale(right_scale)
	content_init.random_content()
	content_init.global_position = origin.global_position
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(content_init,"global_position",display.global_position,move_time)
