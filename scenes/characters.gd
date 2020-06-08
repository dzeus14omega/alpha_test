extends Node2D
class_name Characters

var human_list : Array
var wolf_list  : Array
var character  : Array


func _ready():
	var child = self.get_children()
	for x in child:
		if x is Actor and !(x is Knight):
			#print(GLOBAL.spawn_location[i].x)
			human_list.push_back(x)
			character.push_back(x)
			#print(x.name)
			generate_dialogue(x.name)
		pass
	setup_random_role()
	GLOBAL.human_list = self.human_list
	GLOBAL.character_list = self.character
	GLOBAL.wolf_list = self.wolf_list
	
	#print(wolf_num)
	#print(String(total_character) + " character")

func remove_character(actor: Actor):
	GLOBAL.remove_from_list(actor)
	self.character.erase(actor)
	if human_list.has(actor):
		self.human_list.erase(actor)
	elif wolf_list.has(actor):
		self.wolf_list.erase(actor)
	pass

#func add_character(actor : Actor):
	

func generate_dialogue(actor):
	var tmp = self.get_node("dialogue_controller").setup_norm_dialogue(actor)
	self.get_node(actor).dilivery_dialog(tmp)
	pass

func setup_random_role():
	var total_wolf : int = int(character.size()/3)
	while (wolf_list.size() != total_wolf):
		randomize()
		var rand_num = randi() % (human_list.size() - 1)
		for i in range(human_list.size()):
			if i == rand_num:
				wolf_list.push_back(human_list[i])
				print(human_list[i].name)
				human_list.remove(i)
			pass
		pass


func call_guard(pos : Vector2):
	for x in get_children():
		if(x is Knight):
			x.move_to(pos)
	pass
	#print(wolf_list[0].name)



