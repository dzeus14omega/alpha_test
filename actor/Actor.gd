extends Area2D
class_name Actor 


#export (String) var dialogue_file_path : String
#var id : Array
#var text : Array
#var enumeration : Array
#var conversation : Array
#var wolf : bool = false
#var ability : bool = false

var role : String = "humman"
var state : String = "alive"

func to_wolf():
	self.role = "wolf"

func killed():
	self.state = "dead"
	self.visible = false

func is_human():
	return role == "human"
	
	
#for debuging
#var error = false

#func _ready():
#	var file = File.new()
#	var dialogue: Dictionary
#	var err = file.open(dialogue_file_path, file.READ)
#	if err != OK:
#		printerr("Could not open file, error code ", err)
#		error = true
#	else:
#		dialogue = parse_json(file.get_as_text())
#		file.close()
#		self.conversation = dialogue.values()
#		for x in conversation:
#			id.push_back(x.id)
#			text.push_back(x.dialog)
#			enumeration.push_back(x.enu)
#			pass
#	#print(conversation.size())
#	pass

#
#
#func random_dialogue() -> String:
#	var i = randi() % (text.size() - 1)
#	var result = text[i]
#	return result
