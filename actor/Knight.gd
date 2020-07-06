extends Actor
class_name Knight

enum State_action {
	idle,
	move_left,
	move_right,
	attacking
}

onready var timer = get_node("Timer")
export var bias : Vector2 = Vector2(0,0)
var cur_state = State_action.idle
var time_attack = 10
var counter = 0


func _ready():
	._ready()
	#next_pos = Vector2(-128,-128)\
	timer.set_wait_time(2)
	pass

func get_class():
	return "Hunter"
	
# warning-ignore:unused_argument
func _process(delta):
	animation_controller()
	if(self.position != next_pos):
		var old_pos = self.position
		var walk_distance = character_speed * delta
		#set moving animation
		if(next_pos.x < old_pos.x):
			cur_state = State_action.move_left
		if(next_pos.x > old_pos.x):
			cur_state = State_action.move_right
		#may cause an exception!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! null instance
		var path = get_parent().get_parent().get_parent().get_node("Map")._update_navigation_path(self.position, next_pos + bias)
		move_along_path(walk_distance, path)
		if(self.position == old_pos and self.position != self.spawn_location):
			next_pos = self.position
			timer.start()
			cur_state = State_action.attacking
			yield(timer,"timeout")
			return
		if (self.position == self.spawn_location):
			next_pos = self.position
	else:
		if(cur_state != State_action.attacking):
			cur_state = State_action.idle


func animation_controller():
	if cur_state == State_action.move_left:
		$AnimatedSprite.play("move_left")
		$AnimatedSprite.flip_h = false
	if cur_state == State_action.move_right:
		$AnimatedSprite.play("move_left")
		$AnimatedSprite.flip_h = true
	if cur_state == State_action.idle:
		$AnimatedSprite.play("idle")
	if cur_state == State_action.attacking:
		$AnimatedSprite.play("attack")

func _on_Timer_timeout():
	#print("ok check")
	timer.stop()
	move_to(self.spawn_location - bias)
	pass # Replace with function body.
