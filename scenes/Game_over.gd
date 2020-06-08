extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func human_win():
	$Control.visible = true
	$Control/Human_win.visible = true
	pass
	
func wolf_win():
	$Control.visible = true
	$Control/Wolf_win.visible = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_to_menu_pressed():
	get_tree().change_scene("res://scenes/menu_scene.tscn")
	pass # Replace with function body.
