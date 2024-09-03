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

var is_right = false
var user_name
var password

func _process(delta: float) -> void:
	if !is_right:
		if(is_valid_password_1(pwd_content.get_text())):
			sign2.set_visible(true)
			if(is_valid_password_2(pwd_content.get_text())):
				sign3.set_visible(true)
				if(is_valid_password_3(pwd_content.get_text())):
					sign4.set_visible(true)
					if(is_valid_password_4(pwd_content.get_text())):
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

# 检查字符是否是数字
func is_digit(char):
	return char in "0123456789"

func is_valid_password_1(password):
	var has_upper = false
	var has_lower = false
	var has_digit = false
	for char in password:
		if char.is_valid_identifier():
			if char.to_upper() == char:
				has_upper = true
			else:
				has_lower = true
		elif is_digit(char):
			has_digit = true
	return has_upper and has_lower and has_digit

func is_valid_password_2(password):
	var valid_brands = ["McDonald", "KFC", "Domino"]
	for brand in valid_brands:
		if password.find(brand) != -1:
			return true
	return false

func is_valid_password_3(password):
	var special_characters = "~!@#$%^&*()_+{}|:>?,./;[]-=''"
	for char in password:
		if special_characters.find(char) != -1:
			return true
	return false

func is_valid_password_4(password):
	for i in range(password.length() - 2):
		var current_char = password[i]
		var next_char = password[i + 1]
		var next_next_char = password[i + 2]
		# 检查当前字符和下一个字符是否都是数字
		if is_digit(current_char) and is_digit(next_char):
			var current_num = current_char.to_int()
			var next_num = next_char.to_int()
			# 检查数字差是否小于4
			if abs(current_num - next_num) < 4:
				# 检查下一个字符是否不是字母
				if not next_char.is_valid_identifier():
					return false
		if is_digit(current_char) and is_digit(next_next_char):
			var current_num = current_char.to_int()
			var next_num = next_next_char.to_int()
			# 检查数字差是否小于4
			if abs(current_num - next_num) < 4:
				# 检查下一个字符是否不是字母
				if not next_char.is_valid_identifier():
					return false
	return true
	#末尾处理
	var current_char = password[password.length() - 1]
	var next_char = password[password.length()]
	if is_digit(current_char) and is_digit(next_char):
			var current_num = current_char.to_int()
			var next_num = next_char.to_int()
			# 检查数字差是否小于4
			print(abs(current_num - next_num))
			if abs(current_num - next_num) < 4:
					return false
	
func is_valid_password_5(password):
	var emoji_count = 0
	for char in password:
		if char == "💪":
			emoji_count += 1
		if emoji_count >= 3:
			return true
	return false

func invisible():
	sign1.set_visible(false)
	sign2.set_visible(false)
	sign3.set_visible(false)
	sign4.set_visible(false)
	sign5.set_visible(false)
	
func _on_确认按钮_pressed() -> void:
	if (is_valid_password_1(pwd_content.get_text()) and is_valid_password_2(pwd_content.get_text()) 
	and is_valid_password_3(pwd_content.get_text()) and is_valid_password_4(pwd_content.get_text())
	and is_valid_password_5(pwd_content.get_text())):
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
