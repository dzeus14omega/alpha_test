extends StaticBody2D
class_name House

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_inside_body_entered(body):
	if body is Player or body is player_multiplayer:
		$house_01.visible = false
	pass # Replace with function body.


func _on_inside_body_exited(body) :
	if body is Player or body is player_multiplayer:
		$house_01.visible = true
	pass # Replace with function body.
