extends Node

# 检查字符是否是数字
func is_digit(char) -> bool:
	return char in "0123456789"
# 检查字符是否是字母
func is_alpha(char) -> bool:
	return char in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

func upper_lower_and_digit(password):
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

func contains_brand_name(password):
	var valid_brands = ["McDonald", "KFC", "Domino"]
	for brand in valid_brands:
		if password.find(brand) != -1:
			return true
	return false

func includes_special_character(password):
	var special_characters = "~!@#$%^&*()_+{}|:>?,./;[]-=''"
	for char in password:
		if special_characters.find(char) != -1:
			return true
	return false

func proximity_digits_non_alpha(password):
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
	
func strong_enough(password):
	var emoji_count = 0
	for char in password:
		if char == "💪":
			emoji_count += 1
		if emoji_count >= 3:
			return true
	return false
