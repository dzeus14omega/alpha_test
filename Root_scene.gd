extends Node2D

var spawn_location = [(Vector2(10,10)), (Vector2(20,20)), (Vector2(40,40)), (Vector2(-20,-20)), (Vector2(-60,-20))]
var human_list     : Array
var wolf_list      : Array
var character_list : Array
var total_character = 4
var prison_pos = Vector2(-160,-640)
var arrest_order : String = ""


func check_arrest_order():
	var tmp = arrest_order
	return tmp

func set_arrest_order(character_name : String):
	print(character_name)
	self.arrest_order = character_name

func _ready():
	set_spawn_location()
	suffle_spawn_location()
	#print(human_list.size())
	pass

func suffle_spawn_location():
	randomize()
	spawn_location = spawn_location[randi() % spawn_location.size()]
	
func set_spawn_location():
	#print(spawn_location[0])
	pass
	
func change_scene():
	pass

func remove_from_list(actor : Actor):
	character_list.erase(actor)
	if human_list.has(actor):
		self.human_list.erase(actor)
	elif wolf_list.has(actor):
		self.wolf_list.erase(actor)
	pass
