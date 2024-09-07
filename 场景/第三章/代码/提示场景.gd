extends Control
@onready var 文本: Label = $"VBoxContainer/文本"

func set_text(text:String)->void:
	文本.text = text
