extends Node2D

var move_time:float = 1.0
var is_out = false

@onready var origin: Node2D = $"初始位置"
@onready var display: Node2D = $"显示位置"
@onready var content: Node2D = $"投递内容"
@onready var disappear_pass: Node2D = $"消失位置_跳过"
@onready var disappear_post: Node2D = $"消失位置_投递"

var content_init
const content_scene = preload("res://场景/第二章/场景/投递内容.tscn")

func _on_左边按钮_pressed() -> void:
	if !is_out:
		var tween = create_tween().set_ease(Tween.EASE_OUT)
		tween.tween_property(content,"global_position",disappear_pass.global_position,move_time)
		await get_tree().create_timer(1).timeout
		content.queue_free()
		is_out = true
		create_node()
	else:
		var tween = create_tween().set_ease(Tween.EASE_OUT)
		tween.tween_property(content_init,"global_position",disappear_pass.global_position,move_time)
		await get_tree().create_timer(1).timeout
		content_init.queue_free()
		create_node()

func _on_右边按钮_pressed() -> void:
	if !is_out:
		var tween = create_tween().set_ease(Tween.EASE_OUT)
		tween.tween_property(content,"global_position",disappear_post.global_position,move_time)
		await get_tree().create_timer(1).timeout
		content.queue_free()
		is_out = true
		create_node()
	else:
		var tween = create_tween().set_ease(Tween.EASE_OUT)
		tween.tween_property(content_init,"global_position",disappear_post.global_position,move_time)
		await get_tree().create_timer(1).timeout
		content_init.queue_free()
		create_node()

func create_node():
	content_init = content_scene.instantiate()
	add_child(content_init)
	content_init.random_content()
	content_init.global_position = origin.global_position
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(content_init,"global_position",display.global_position,move_time)
