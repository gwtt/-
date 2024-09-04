extends Node2D

@onready var login_panel: PanelContainer = $Control/PanelContainer
@onready var logon_panel: PanelContainer = $Control/PanelContainer2
@onready var name_content: LineEdit = $"Control/PanelContainer2/HBoxContainer/VBoxContainer/HBoxContainer/用户名"
@onready var pwd_content: LineEdit = $"Control/PanelContainer2/HBoxContainer/VBoxContainer/HBoxContainer2/密码"
@onready var name_input: LineEdit = $"Control/PanelContainer/VBoxContainer/HBoxContainer/用户名"
@onready var pwd_input: LineEdit = $"Control/PanelContainer/VBoxContainer/HBoxContainer2/密码"

@onready var sign1: Label = $"Control/PanelContainer2/HBoxContainer/VBoxContainer2/密码提示1"
@onready var sign2: Label = $"Control/PanelContainer2/HBoxContainer/VBoxContainer2/密码提示2"
@onready var sign3: Label = $"Control/PanelContainer2/HBoxContainer/VBoxContainer2/密码提示3"
@onready var sign4: Label = $"Control/PanelContainer2/HBoxContainer/VBoxContainer2/密码提示4"
@onready var sign5: Label = $"Control/PanelContainer2/HBoxContainer/VBoxContainer2/密码提示5"
@onready var success: Label = $"Control/PanelContainer2/HBoxContainer/VBoxContainer2/注册成功"
@onready var empty: Label = $"Control/PanelContainer2/HBoxContainer/VBoxContainer2/用户名为空"
@onready var logon: Button = $"Control/PanelContainer/VBoxContainer/HBoxContainer3/注册按钮"

var is_right = false
var signs=[]
var user_name
var password
var password_to_validate
var upper_lower_digit_validator = UpperLowerDigitValidator.new()
var brand_name_validator = BrandNameValidator.new()
var special_character_validator = SpecialCharacterValidator.new()
var proximity_digits_non_alpha_validator = ProximityDigitsNonAlphaValidator.new()
var strong_enough_validator = StrongEnoughValidator.new()

func _ready():
	upper_lower_digit_validator.set_next_validator(brand_name_validator)
	brand_name_validator.set_next_validator(special_character_validator)
	special_character_validator.set_next_validator(proximity_digits_non_alpha_validator)
	proximity_digits_non_alpha_validator.set_next_validator(strong_enough_validator)
	signs = [sign2, sign3, sign4, sign5]

func _process(delta: float) -> void:
	if !is_right:
		password_to_validate = pwd_content.get_text()
		upper_lower_digit_validator.validate_and_show_sign(password_to_validate,signs,0)
		

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
	password_to_validate = pwd_content.get_text()
	if (upper_lower_digit_validator.validate(password_to_validate) and brand_name_validator.validate(password_to_validate)
	and special_character_validator.validate(password_to_validate) and proximity_digits_non_alpha_validator.validate(password_to_validate)
	and strong_enough_validator.validate(password_to_validate)):
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

class PasswordValidator:
	var next_validator: PasswordValidator
	func set_next_validator(validator: PasswordValidator):
		self.next_validator = validator

	func validate(password: String) -> bool:
		return false

	func validate_and_show_sign(password: String, signs: Array, sign_index:int):
		var is_valid = validate(password)
		if is_valid and next_validator:
			signs[sign_index].set_visible(is_valid)
			sign_index += 1
			next_validator.validate_and_show_sign(password, signs,sign_index)
		
	# 检查字符是否是数字
	func is_digit(char) -> bool:
		return char in "0123456789"
	# 检查字符是否是字母
	func is_alpha(char) -> bool:
		return char in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

class UpperLowerDigitValidator extends PasswordValidator:
	func validate(password: String) -> bool:
		var has_upper = false
		var has_lower = false
		var has_digit = false
		for char in password:
			if is_alpha(char):
				if char.to_upper() == char:
					has_upper = true
				else:
					has_lower = true
			elif is_digit(char):
				has_digit = true
		return has_upper and has_lower and has_digit

class BrandNameValidator extends PasswordValidator:
	func validate(password: String) -> bool:
		var valid_brands = ["McDonald", "KFC", "Domino"]
		for brand in valid_brands:
			if password.find(brand) != -1:
				return true
		return false

class SpecialCharacterValidator extends PasswordValidator:
	func validate(password: String) -> bool:
		var special_characters = "~!@#$%^&*()_+{}|:>?,./;[]-=''"
		for char in password:
			if special_characters.find(char) != -1:
				return true
		return false

class ProximityDigitsNonAlphaValidator extends PasswordValidator:
	func validate(password: String) -> bool:
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
					if not is_alpha(next_char):
						return false
			if is_digit(current_char) and is_digit(next_next_char):
				var current_num = current_char.to_int()
				var next_num = next_next_char.to_int()
				# 检查数字差是否小于4
				if abs(current_num - next_num) < 4:
					# 检查下一个字符是否不是字母
					if not is_alpha(next_char):
						return false
		return true
		#末尾处理
		var current_char = password[password.length() - 1]
		var next_char = password[password.length()]
		if is_digit(current_char) and is_digit(next_char):
				var current_num = current_char.to_int()
				var next_num = next_char.to_int()
				# 检查数字差是否小于4
				if abs(current_num - next_num) < 4:
						return false
	
class StrongEnoughValidator extends PasswordValidator:
	func validate(password: String) -> bool:
		var emoji_count = 0
		for char in password:
			if char == "💪":
				emoji_count += 1
			if emoji_count >= 3:
				return true
		return false
