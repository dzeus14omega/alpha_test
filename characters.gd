extends Node2D
class_name Characters


var human_num : int
var wolf_num : int
var total_character = 0 
var character_list : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	var child = self.get_children()
	for x in child:
		if x is Actor:
			character_list.push_back(x)
			#print(x.name)
			generate_dialogue(x.name)
		pass
	pass
	
	total_character = character_list.size()
	wolf_num = int(total_character/3)
	human_num = total_character - wolf_num
	var i = randi() % (total_character - 1)
	#print(wolf_num)
	#print(String(total_character) + " character")
	
	pass # Replace with function body.

func generate_dialogue(actor):
	var tmp = self.get_node("dialogue_controller").setup_norm_dialogue(actor)
	self.get_node(actor).dilivery_dialog(tmp)
	pass


#func _process(delta):
#	pass
