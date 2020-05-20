extends Navigation2D
class_name Map_navigate

export(float) var CHARACTER_SPEED = 200.0

var target_charater : Actor



# The 'click' event is a custom input action defined in
# Project > Project Settings > Input Map tab


#
func _input(event):
	if not InputEventScreenTouch:
		return
	#_update_navigation_path(target_charater.position, get_local_mouse_position())
	print(get_local_mouse_position())

func _update_navigation_path(start_position, end_position):
	var path = []
	# get_simple_path is part of the Navigation2D class
	# it returns a PoolVector2Array of points that lead you from the
	# start_position to the end_position
	path = get_simple_path(start_position, end_position, true)
	# The first point is always the start_position
	# We don't need it in this example as it corresponds to the character's position
	path.remove(0)
	return path
