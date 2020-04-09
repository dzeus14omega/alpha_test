extends Actor
class_name Seer


var current_dialogues : Array

func _ready():
	pass

###------------------ Show dialog-----------------###
#####################################################

# warning-ignore:unused_argument
func _process(delta):
	$AnimatedSprite.play("idle")
	pass


func _on_Seer_body_entered(body):
	if self.position.x - body.position.x < 0:
		$AnimatedSprite.flip_h = true
		#$AnimatedSprite.flip_h = false
	self.get_node("Control/RichTextLabel").set_bbcode(update_dialogue())
	self.get_node("Control").visible = true
	#$CollisionShape2D.set_deferred("disabled", true)


func _on_Seer_body_exited(body):
	$AnimatedSprite.flip_h = false
	self.get_node("Control").visible = false
	pass # Replace with function body.

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
	self.ability = true
	pass








