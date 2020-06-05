extends Actor
class_name Seer


var current_dialogues : Array
var state_action
enum State_action {
	wanted,
	arrest,
	go_outside,
	meet_player,
	free
}

func _ready():
	state_action = State_action.go_outside
	pass

###------------------ Show dialog-----------------###
#####################################################

# warning-ignore:unused_argument
func _process(delta):
	#set auto move
	if GLOBAL.check_arrest_order() == self.name and state_action != State_action.arrest:
		state_action = State_action.wanted
	if state_action != State_action.arrest:
		if(state_action == State_action.wanted or state_action == State_action.meet_player):
			next_pos = position
			$Timer.stop()
		else:
			auto_move()
	
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


func auto_move():
	if state_action == State_action.go_outside:
		move_to(spawn_location + Vector2(0,100))
		if(position == spawn_location + Vector2(0,100)):
			state_action = State_action.free
		pass
	if state_action == State_action.free:
		if($Timer.is_stopped()):
			$Timer.start()

func _on_Timer_timeout():
	randomize()
	var time = randi() % 5 +1
	$Timer.set_wait_time(time)
	var x = (randi() % 400) - 200
	var y = (randi() % 400) - 200
	move_to(position + Vector2(x,y))
	pass

func _on_Seer_body_entered(body):
	if body is Player:
		if state_action != State_action.arrest and state_action != State_action.wanted:
			state_action = State_action.meet_player
		if self.position.x - body.position.x < 0:
			$AnimatedSprite.flip_h = true
			#$AnimatedSprite.flip_h = false
		self.get_node("Control/RichTextLabel").set_bbcode(update_dialogue())
		self.get_node("Control").visible = true
	#$CollisionShape2D.set_deferred("disabled", true)
	if body is Knight and state_action == State_action.wanted:
		state_action = State_action.arrest


func _on_Seer_body_exited(body):
	if body is Player:
		$AnimatedSprite.flip_h = false
		self.get_node("Control").visible = false
		if state_action != State_action.arrest and state_action != State_action.wanted:
			state_action = State_action.free
	if body is Knight and state_action == State_action.arrest:
		print("arrest")
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
	print("Seer cast ability")
	pass

