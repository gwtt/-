extends Node2D

@onready var character = $CharacterBody2D/AnimatedSprite2D
@onready var button_1 = $CharacterBody2D/Button1
@onready var button_2 = $CharacterBody2D/Button2
@onready var boom_1 = $CharacterBody2D/Button1/Boom1
@onready var boom_2 = $CharacterBody2D/Button2/Boom2

var StartPos : Vector2
var EndPos : Vector2
var StartMod : Color
var EndMod : Color

func _ready():
	_button_appear(button_1)
	_button_appear(button_2)
	
func _button_appear(button):
	StartPos = button.position
	EndPos = StartPos-Vector2(0,300)
	create_tween().tween_property(button,"position",EndPos,1.5)
	StartMod = Color(1,1,1,1)
	create_tween().tween_property(button,"modulate",StartMod,1.5)

func _on_button_2_pressed():
	_on_button_pressed(button_2)
	boom_2.set_visible(true)
	
func _on_button_1_pressed():
	_on_button_pressed(button_1)
	boom_1.set_visible(true)
	
func _on_button_pressed(button):
	EndMod = Color(1,1,1,0)
	var DisPos = button.position+Vector2(0,500)
	#位置消失
	#create_tween().tween_property(button,"position",DisPos,1.5)
	#逐渐透明
	create_tween().tween_property(button,"modulate",EndMod,1.5)
