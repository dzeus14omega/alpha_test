extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_sendButton_pressed():
	if ($messageBox.text != ""):
		print($messageBox.text)
		var p = get_parent()
		if p.has_method("update_message"):
			p.update_message($messageBox.text)
			pass
	$messageBox.clear()
	pass # Replace with function body.
