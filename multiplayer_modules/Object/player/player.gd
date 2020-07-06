extends KinematicBody2D
class_name player_multiplayer


var joystick_move
var speed = 150
var ui = preload("res://multiplayer_modules/UI/UI.tscn")
puppet var puppet_pos = Vector2()
puppet var puppet_motion = Vector2()
var current_anim = ""

var outFit 
var role = "human"
var vote = 0



func _physics_process(_delta):
	var motion = _move(_delta)

	if motion.x < 0:
		outFit.play("move_left")
		outFit.flip_h = false
	if motion.x > 0:
		outFit.play("move_left")
		outFit.flip_h = true
	if motion.x == 0 and motion.y == 0:
		outFit.play("idle")
		
		
	# FIXME: Use move_and_slide
	if not is_network_master():
		puppet_pos = position # To avoid jitter

func _move(delta: float) -> Vector2:
	var motion = Vector2(0,0)
	if is_network_master():
		if joystick_move and joystick_move.is_working:
			motion = joystick_move.output * speed
			move_and_slide(motion)
		rset("puppet_motion", motion)
		rset("puppet_pos", position)
	else:
		position = puppet_pos
		motion = puppet_motion
	return motion


func set_player_name(new_name):
	$label.set_text(new_name)

func set_outfit(outfit):
	var path = "res://multiplayer_modules/Object/outfit/" + outfit + "_style.tscn"
	print(path)
	self.outFit = load(path).instance()
	add_child(outFit)
	pass

func _ready():
#	stunned = false
	puppet_pos = position
	if is_network_master():
		#add camera2d
		var cam = Camera2D.new()
		cam._set_current(true)
		add_child(cam)
		#add ui
		var main_ui = ui.instance()
		add_child(main_ui)
		self.joystick_move = main_ui.get_node("Joystick")

sync func showMessage(message):
	$ColorRect/RichTextLabel.text = message
	$TimerMessage.set_wait_time(4)
	$TimerMessage.start()
	$ColorRect.visible = true
	pass

func update_message(message):
	rpc("showMessage",message)
	

func _on_TimerMessage_timeout():
	$TimerMessage.stop()
	$ColorRect.visible = false
	pass # Replace with function body.
