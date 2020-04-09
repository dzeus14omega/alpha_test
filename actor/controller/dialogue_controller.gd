extends Control
class_name Dialogue_manager

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (String) var dialogue_file_path : String
var dialogues: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	var json_form : Dictionary
	var err = file.open(dialogue_file_path, file.READ)
	if err != OK:
		printerr("Could not open file, error code ", err)
	else:
		json_form = parse_json(file.get_as_text())
		file.close()
		dialogues = json_form.values()
	pass# Replace with function body.

func setup_norm_dialogue(key) -> Array:
	var tmp : Array
	for x in dialogues:
		if x.role == key:
			if x.enu == "norm":
				tmp.push_back(x.dialog)
			pass
		pass
	pass
	return tmp

func quick_action_dialogue(key : String) -> Array:
	var tmp : Array
	for x in dialogues:
		if x.role == key:
			if x.enu == "quick-action":
				tmp.push_back(x.dialog)
			pass
		pass
	pass
	return tmp

func warning_dialogue(key : String) -> Array:
	var tmp : Array
	for x in dialogues:
		if x.role == key:
			if x.enu == "warn":
				tmp.push_back(x.dialog)
			pass
		pass
	pass
	return tmp

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
