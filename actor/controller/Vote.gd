extends Control

enum state {IN, OUT}
var current_state
var list_character
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = state.OUT
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	if(current_state == state.OUT):
		self.get_parent().get_node("AnimationPlayer").play("slide_in")
		current_state = state.IN
	else:
		self.get_parent().get_node("AnimationPlayer").play("slide_out")
		current_state = state.OUT
	pass # Replace with function body.
