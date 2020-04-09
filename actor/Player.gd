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
	if joystick_move.output.x < 0:
		$AnimatedSprite.play("move_left")
		$AnimatedSprite.flip_h = false
	if joystick_move.output.x > 0:
		$AnimatedSprite.play("move_left")
		$AnimatedSprite.flip_h = true
	if joystick_move.output == Vector2(0,0):
		$AnimatedSprite.play("idle")
	pass

func _move(delta: float) -> void:
	if joystick_move and joystick_move.is_working:
		move_and_slide(joystick_move.output * speed)


