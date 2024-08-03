extends GameInit

@onready var 主角 = $"白色框/主角"
var timer:Timer
func _ready():
	timer = Timer.new() 
	timer.wait_time = 1.0
	timer.timeout.connect(_眨眼)
	add_child(timer)
	timer.start()


func _眨眼():
	主角.play("眨眼")
