extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var human_num : int
var wolf_num : int
var total_character = 0 

# Called when the node enters the scene tree for the first time.
func _ready():
	var child = self.get_children()
	for x in child:
		if x is Actor:
			total_character += 1
	print(total_character)
	
	var tmp = self.get_node("dialogue_controller").setup_norm_dialogue("hunter")
	self.get_node("Hunter").dilivery_dialog(tmp)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
