extends Node2D

@onready var login_panel: PanelContainer = $PanelContainer
@onready var logon_panel: PanelContainer = $PanelContainer2
@onready var name_content: LineEdit = $"PanelContainer2/HBoxContainer/VBoxContainer/HBoxContainer/用户名"
@onready var pwd_content: LineEdit = $"PanelContainer2/HBoxContainer/VBoxContainer/HBoxContainer2/密码"
@onready var name_input: LineEdit = $"PanelContainer/VBoxContainer/HBoxContainer/用户名"
@onready var pwd_input: LineEdit = $"PanelContainer/VBoxContainer/HBoxContainer2/密码"

@onready var sign1: Label = $"PanelContainer2/HBoxContainer/VBoxContainer2/密码提示1"
@onready var sign2: Label = $"PanelContainer2/HBoxContainer/VBoxContainer2/密码提示2"
@onready var sign3: Label = $"PanelContainer2/HBoxContainer/VBoxContainer2/密码提示3"
@onready var sign4: Label = $"PanelContainer2/HBoxContainer/VBoxContainer2/密码提示4"
@onready var sign5: Label = $"PanelContainer2/HBoxContainer/VBoxContainer2/密码提示5"
@onready var success: Label = $"PanelContainer2/HBoxContainer/VBoxContainer2/注册成功"
@onready var empty: Label = $"PanelContainer2/HBoxContainer/VBoxContainer2/用户名为空"
@onready var logon: Button = $"PanelContainer/VBoxContainer/HBoxContainer3/注册按钮"

const PwdValidate = preload("res://场景/第三章/代码/PwdValidate.gd")
var password_validator = PwdValidate.new()

var is_right = false
var user_name
var password

func _process(delta: float) -> void:
	if !is_right:
		if(password_validator.upper_lower_and_digit(pwd_content.get_text())):
			sign2.set_visible(true)
			if(password_validator.contains_brand_name(pwd_content.get_text())):
				sign3.set_visible(true)
				if(password_validator.includes_special_character(pwd_content.get_text())):
					sign4.set_visible(true)
					if(password_validator.proximity_digits_non_alpha(pwd_content.get_text())):
						sign5.set_visible(true)

func _on_注册按钮_pressed() -> void:
	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(login_panel,"modulate",Color(1,1,1,0),0.2)
	tween.tween_property(logon_panel,"modulate",Color(1,1,1,1),0.2)
	tween.tween_property(login_panel,"visible",false,0.2)
	tween.tween_property(logon_panel,"visible",true,0.2)
	pwd_content.set_text("💪")
	name_content.set_text("")
	sign2.set_visible(false)
	sign3.set_visible(false)
	sign4.set_visible(false)
	sign5.set_visible(false)

func _on_返回按钮_pressed() -> void:
	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(logon_panel,"modulate",Color(1,1,1,0),0.2)
	tween.tween_property(login_panel,"modulate",Color(1,1,1,1),0.2)
	tween.tween_property(logon_panel,"visible",false,0.2)
	tween.tween_property(login_panel,"visible",true,0.2)
	name_input.set_text("")
	pwd_input.set_text("")

func invisible():
	sign1.set_visible(false)
	sign2.set_visible(false)
	sign3.set_visible(false)
	sign4.set_visible(false)
	sign5.set_visible(false)
	
func _on_确认按钮_pressed() -> void:
	if (password_validator.upper_lower_and_digit(pwd_content.get_text()) and password_validator.contains_brand_name(pwd_content.get_text()) 
	and password_validator.includes_special_character(pwd_content.get_text()) and password_validator.proximity_digits_non_alpha(pwd_content.get_text())
	and password_validator.strong_enough(pwd_content.get_text())):
		is_right = true
		invisible()
		if (name_content.get_text() == ""):
			empty.set_visible(true)
		else:
			empty.set_visible(false)
			success.set_visible(true)
			await get_tree().create_timer(1).timeout
			_on_返回按钮_pressed()
			user_name=name_content.get_text()
			password=pwd_content.get_text()

func _on_登录按钮_pressed() -> void:
	if(name_input.get_text()==user_name and pwd_input.get_text()==password):
		GlobalGameManager.emit_complete_game()
