extends Node2D
@onready var 登录用户名: LineEdit = $"Control/登录界面/VBoxContainer/MarginContainer/互动层/用户名/用户名/用户输入框"
@onready var 登录密码: LineEdit = $"Control/登录界面/VBoxContainer/MarginContainer/互动层/密码/密码/密码输入框"
@onready var 注册用户名: LineEdit = $"Control/注册界面/VBoxContainer/MarginContainer/互动层/用户名/用户名/用户输入框"
@onready var 注册密码: LineEdit = $"Control/注册界面/VBoxContainer/MarginContainer/互动层/密码/密码/密码输入框"

@onready var 提示场景: PanelContainer = $"Control/注册界面/VBoxContainer/提示/提示场景"
@onready var 登录界面: MarginContainer = $"Control/登录界面"
@onready var 注册界面: MarginContainer = $"Control/注册界面"
@onready var 注册: Button = $"Control/登录界面/VBoxContainer/MarginContainer/互动层/操作层/按钮/注册按钮"
@onready var 登录: Button = $"Control/登录界面/VBoxContainer/MarginContainer/互动层/操作层/按钮/登录按钮"
@onready var kapibala: AnimatedSprite2D = $"卡皮巴拉"

var remind = {
	1: "提示1：密码需要包含数字",
	2: "提示2：密码需要包含大写字母",
	3: "提示3：密码需要包含至少一个特殊符号",
	4: "提示4：密码中数字和数字之间若差小于4，必须中间隔一个字母",
	5: "提示5：您的密码不足9位",
	6: "提示6：您的密码不够强壮"
}
var animation = {
	1: "grass",
	2: "walk",
	3: "sitting_1",
	4: "sitting_2"
}
var account:Dictionary  = {}
var flag:bool = false #是否可以注册


func _ready() -> void:
	提示场景.set_text(remind.get(1))
	kapibala_play()
	
func kapibala_play():
	kapibala.play(animation[randi_range(1,animation.size())])
	
func 检验(s:String)->int:
	if !提示1(s):
		return 1
	if !提示2(s):
		return 2
	if !提示3(s):
		return 3
	if !提示4(s):
		return 4
	if !提示5(s):
		return 5	
	if !提示6(s):
		return 6	
	return 0
	
func 提示1(s:String)->bool:
	return 检测是否有数字(s)

func 提示2(s:String)->bool:
	return 检测是否有大写字母(s)
	
func 提示3(s:String)->bool:
	var regex = RegEx.new()
	regex.compile("[!@#$%^&(),.?\":{}|<>]")
	return regex.search(s)!=null
	
func 提示4(s:String)->bool:
	var regex = RegEx.new()
	regex.compile("([0-9])([0-9])")
	var result = regex.search(s)
	if result:
		var first_number = int(result.get_strings()[1])
		var second_number = int(result.get_strings()[2])
		if abs(first_number - second_number) == 4:
			return true
		else:
			return false
	return true;
	
func 提示5(s:String)->bool:
	return s.length() >= 9;
	
func 提示6(s:String)->bool:
	var emoji_count = 0
	for char in s:
		if char == "💪":
			emoji_count += 1
		if emoji_count >= 3:
			return true
	return false
	
func 检测是否有数字(s:String)->bool:
	var regex = RegEx.new()
	regex.compile("\\d")
	return regex.search(s)!=null
	
func 检测是否有大写字母(s:String)->bool:
	var regex = RegEx.new()
	regex.compile("[A-Z]")
	return regex.search(s)!=null

func 检测是否有小写字母(s:String)->bool:
	var regex = RegEx.new()
	regex.compile("[a-z]")
	return regex.search(s)!=null
		
#注册确认
func _on_确认按钮_pressed() -> void:
	if flag:
		account.get_or_add(注册用户名.text,注册密码.text)
		注册界面.visible = false
		登录界面.visible = true
		kapibala_play()
		登录用户名.text = ""
		登录密码.text = ""

func _on_注册按钮_pressed() -> void:
	注册界面.visible = true
	登录界面.visible = false
	kapibala_play()
	注册密码.text = "💪"
	注册用户名.text = ""
func _on_登录按钮_pressed() -> void:
	GlobalGameManager.emit_complete_game()

func _on_返回按钮_pressed() -> void:
	注册界面.visible = false
	登录界面.visible = true
	kapibala_play()
	登录用户名.text = ""
	登录密码.text = ""

func _on_密码输入框_text_changed(new_text: String) -> void:
	#提示文字的key值
	var text_index = 检验(new_text)
	if remind.get(text_index):
		flag = false
		提示场景.set_text(remind.get(text_index))
	else:
		flag = true	
		提示场景.set_text("")
