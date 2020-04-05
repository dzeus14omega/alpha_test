extends KinematicBody2D
class_name Player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 150
onready var joystick_move := $UI/JoystickMove
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	_move(delta)
#	move_and_slide(joystick.get_value() * speed)
#	if joystick.get_value() == Vector2(0,0):
#		pass
#	if joystick.get_value().x >= 0:
#		$AnimatedSprite.flip_h = true
#	else:
#		$AnimatedSprite.flip_h = false

	
	
#	var motion = Vector2()
#	if(Input.is_action_pressed("ui_left")):
#		motion.x -= 1
#	if(Input.is_action_pressed("ui_right")):
#		motion.x += 1
#	if(Input.is_action_pressed("ui_down")):
#		motion.y += 1
#	if(Input.is_action_pressed("ui_up")):
#		motion.y -= 1
#	if(motion.length() > 0):
#		motion = motion.normalized() * speed
#		$AnimatedSprite.play()
	pass

func _move(delta: float) -> void:
	if joystick_move and joystick_move.is_working:
		move_and_slide(joystick_move.output * speed)


