extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func end_day_active():
	$AnimationPlayer.clear_caches()
	$AnimationPlayer.play("slide_down")

	pass

func night_end():
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("night_end")
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	#end_day_active()
	$message_newday.visible=true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
