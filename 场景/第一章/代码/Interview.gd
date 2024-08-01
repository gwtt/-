extends Node2D

var bubble_scene = preload("res://场景/第一章/场景/对话气泡.tscn")
var bubble_init_array : Array

func _ready():
	for i in range(30):
		var bubble_init = bubble_scene.instantiate()
		bubble_init_array.push_front(bubble_init)
		
func _on_开始按钮_pressed():
	for i in range(30):
		add_child(bubble_init_array[i])
		bubble_init_array[i].set_position(Vector2(randi_range(-700,700),randi_range(200,400)))
		bubble_init_array[i]._button_appear()
		await get_tree().create_timer(2).timeout
