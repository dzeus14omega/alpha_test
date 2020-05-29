extends Actor
class_name Bodyguard

var current_dialogues : Array

func _ready():
	pass

###------------------ Show dialog-----------------###
#####################################################

# warning-ignore:unused_argument
func _process(delta):
	#set moving animation
	if(next_pos.x < self.position.x):
			$AnimatedSprite.play("walk")
			$AnimatedSprite.flip_h = false
	if(next_pos.x > self.position.x):
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	
	if(self.position != next_pos):
		var old_pos = self.position
		var walk_distance = character_speed * delta
		#may cause an exception!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! null instance
		var path = get_parent().get_parent().get_parent().get_node("Map")._update_navigation_path(self.position, next_pos)
		move_along_path(walk_distance, path)
		if(self.position == old_pos):
			next_pos = self.position
			return
	else:
		$AnimatedSprite.play("idle")

func _on_Bodyguard_body_entered(body):
	if body is Player:
		if self.position.x - body.position.x < 0:
			$AnimatedSprite.flip_h = true
			#$AnimatedSprite.flip_h = false
		self.get_node("Control/RichTextLabel").set_bbcode(update_dialogue())
		self.get_node("Control").visible = true
	#$CollisionShape2D.set_deferred("disabled", true)

func _on_Bodyguard_body_exited(body):
	if body is Player:
		$AnimatedSprite.flip_h = false
		self.get_node("Control").visible = false
	if body is Knight:
		if GLOBAL.check_arrest_order() == self.name:
			#print(GLOBAL.check_arrest_order() + " " + self.name)
			move_to(GLOBAL.prison_pos)

#update dialog to change in bbcode
func update_dialogue()-> String:
	if (current_dialogues.size() == 0):
		return ""
	var i = randi() % (current_dialogues.size() - 1)
	var result = current_dialogues[i]
	return result

#listening event to change own's dialog
func dilivery_dialog(new_dialog : Array):
	self.current_dialogues = new_dialog
	

func cast_ability():
	#code...
	#self.ability = true
	print("bodyguard cast ability")
	pass





