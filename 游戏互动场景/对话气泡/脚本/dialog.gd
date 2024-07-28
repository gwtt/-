extends Node2D

@onready var bubble_1 = $CharacterBody2D/Bubble1
@onready var bubble_2 = $CharacterBody2D/Bubble2
var bubble_scene = preload("res://游戏互动场景/对话气泡/场景/bubble.tscn")
var bubble_init_array : Array

func _ready():
	for i in range(30):
		var bubble_init = bubble_scene.instantiate()
		bubble_init_array.push_front(bubble_init)
	for i in range(30):
		add_child(bubble_init_array[i])
		bubble_init_array[i].set_position(Vector2(randi_range(-700,700),randi_range(200,400)))
		bubble_init_array[i]._button_appear()
		await get_tree().create_timer(2).timeout
