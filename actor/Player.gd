extends KinematicBody2D
class_name Player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 150
onready var joystick_move := $UI/JoystickMove
# Called when the node enters the scene tree for the first time.

func _ready():
	#$anim.play("idle")
	pass # Replace with function body.

func update():
	$UI/Vote_action/Panel/ScrollContainer/VBoxContainer.update_list()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	_move(delta)
	if joystick_move.output.x < 0:
		$anim.play("move_left")
		$anim.flip_h = false
	if joystick_move.output.x > 0:
		$anim.play("move_left")
		$anim.flip_h = true
	if joystick_move.output == Vector2(0,0):
		$anim.play("idle")
	pass

func _move(delta: float) -> void:
	if joystick_move and joystick_move.is_working:
		move_and_slide(joystick_move.output * speed)



func _on_Confirm_button_pressed():
	var list_button = get_node("UI/Vote_action/Panel/ScrollContainer/VBoxContainer").get_children()
	var target_character
	for x in list_button:
		if x.pressed:
			target_character = x.name
			#print(x.name)
			break
	if target_character == null:
		return
	get_parent().get_parent().vote_activate(target_character)
	$UI/Vote_action._on_Button_pressed()
	pass # Replace with function body.
