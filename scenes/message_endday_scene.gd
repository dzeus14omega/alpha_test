extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func end_day_active():
	$AnimationPlayer.clear_caches()
	$AnimationPlayer.play("slide_down")
	pass

func night_end(num_dead : int):
	yield($AnimationPlayer,"animation_finished")
	if (num_dead == 0):
		$message_newday/message.bbcode_text = "DAY " + str(GLOBAL.day_num) + "\n Good news, no body dead"
	else:
		$message_newday/message.bbcode_text = "DAY " + str(GLOBAL.day_num) + "\n" + str(num_dead) + " dead bodies =("
	$AnimationPlayer.play("night_end")
	get_parent().morning_event_process()
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	#end_day_active()
	$message_newday.visible=true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
