extends KinematicBody2D
class_name Actor 

var role : String 

export var spawn_location : Vector2 setget set_spawn_location, get_spawn_location
var character_speed
var next_pos : Vector2

#-------------------------------------------------------------------------------
func _ready():
	role = "humman"
	character_speed = 200
	next_pos = self.position

func set_spawn_location(a: Vector2):
	spawn_location = a

func get_spawn_location():
	return spawn_location

func to_wolf():
	self.role = "wolf"

func kill():
	get_parent().remove_character(self)
	self.queue_free()
	

func is_human():
	return role == "human"

func move_to(pos : Vector2):
	next_pos = pos

func move_along_path(distance, path):
	var last_point = self.position
	while path.size():
		var distance_between_points = last_point.distance_to(path[0])
		# the position to move to falls between two points
		if distance <= distance_between_points:
			self.position = last_point.linear_interpolate(path[0], distance / distance_between_points)
			return
		# the position is past the end of the segment
		distance -= distance_between_points
		last_point = path[0]
		path.remove(0)
	# the character reached the end of the path
	self.position = last_point

func cast_ability():
	pass






#export (String) var dialogue_file_path : String
#var id : Array
#var text : Array
#var enumeration : Array
#var conversation : Array
#var wolf : bool = false
#var ability : bool = false

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

#func random_dialogue() -> String:
#	var i = randi() % (text.size() - 1)
#	var result = text[i]
#	return result
#func _process(delta):
	
	
