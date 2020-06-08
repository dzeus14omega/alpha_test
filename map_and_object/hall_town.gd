extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_excution_area_body_entered(body):
	if body is Actor and !(body is Knight):
		if GLOBAL.arrest_order == body.name:
			body.kill()
			get_parent().get_parent().get_parent().end_event_day()
	pass # Replace with function body.
