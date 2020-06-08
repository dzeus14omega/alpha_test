extends YSort
#
## Declare member variables here. Examples:
## var a = 2
## var b = "text"
#var _statement_event
#var dead_list : Array
#var day_num
#
#enum state {
#	morning,
#	day,
#	endday
#}
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	day_num = 1
#	dead_list = []
#	_statement_event = state.day
#	pass # Replace with function body.
#
#func _change_state():
#	match _statement_event:
#		state.day:
#			_statement_event = state.endday
#		state.endday:
#			_statement_event = state.morning
#		state.morning:
#			_statement_event = state.day
#	pass
#
#
#func vote_activate(name_character : String):
#	GLOBAL.set_arrest_order(name_character)
#	var list_character = GLOBAL.character_list
#	var tmp : Actor
#	for x in list_character:
#		if x.name == name_character:
#			tmp = x
#			break
#	get_node("Characters").call_guard(tmp.position)
#	pass
#
#
#func end_event_day():
#	if _statement_event == state.day:
#		day_num += 1
#		GLOBAL.day_num = self.day_num
#		_change_state()
#		get_parent().get_node("splash_scene_endday").end_day_active()
#		night_event_process()
#	pass
#
#func night_event_process():
#	wolf_turn()
#	human_turn()
#	_change_state()
#	get_parent().get_node("splash_scene_endday").night_end()
#	pass
#
#func morning_event_process():
#	_change_state()
#	$Player.update()
#	if GLOBAL.character_list.size() != 0:
#		for x in GLOBAL.character_list:
#			x.reset_to_spawn_pos()
#	pass
#
#func wolf_turn():
#	var tmp_list = GLOBAL.human_list
#	randomize()
#	self.dead_list.push_back(tmp_list[randi()%tmp_list.size() - 1])
#	pass
#
#func human_turn():
#	var tmp_list = GLOBAL.human_list
#	for x in tmp_list:
#		x.cast_ability()
#	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
