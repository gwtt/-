extends Node2D

@onready var bubble_1 = $CharacterBody2D/Bubble1
@onready var bubble_2 = $CharacterBody2D/Bubble2

func _ready():
	bubble_1._button_appear()
	bubble_2._button_appear()
