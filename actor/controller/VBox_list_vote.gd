extends VBoxContainer
class_name Vote_list

var group = ButtonGroup.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	update_list()
	pass # Replace with function body.

func clear_list():
	var tmp = self.get_children()
	for x in tmp:
		x.free()
	pass

func update_list():
	clear_list()
	var alive_character = GLOBAL.character_list
	if alive_character.empty():
		return
	for x in alive_character:
		var new_button = Button.new()
		new_button.set_button_icon(load("res://icon.png"))
		new_button.set_name(x.name)
		new_button.set_text(x.name)
		new_button.toggle_mode = true
		new_button.set_button_group(group)
		self.add_child(new_button)
	pass

#func _process(delta):
#	pass

#
#func _on_Confirm_button_pressed():
#	var list_button = self.get_children()
#	for x in list_button:
#		if x.pressed:
#
#			print(x.name)
#
#	pass # Replace with function body.
