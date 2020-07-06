extends Node2D

# Default game port. Can be any number between 1024 and 49151.
const DEFAULT_PORT = 10567

# Max number of players.
const MAX_PEERS = 12

# Name for my player.
var player_name = "The Warrior"

# Names for remote players in id:name format.
var players = {};
var players_ready = []
var player_outfits = {}

#get selected outfit from lobby
func get_current_outfit():
	return get_tree().get_root().get_node("Lobby").get_outfit()

#get outfit from peer
remote func request_outfit(p):
	rpc_id(1, "add_outfit", get_current_outfit(),p)
	return get_current_outfit()

# return outfit for server
remote func add_outfit(outfit, peer):
	if get_tree().is_network_server():
		player_outfits[peer] = outfit
		#print(player_outfits)
	emit_signal("outfit_added")
	pass


# Signals to let lobby GUI know what's going on.
signal player_list_changed()
signal connection_failed()
signal connection_succeeded()
signal game_ended()
signal game_error(what)
signal outfit_added()

# Callback from SceneTree.
func _player_connected(id):
	# Registration of a client beings here, tell the connected player that we are here.
	rpc_id(id, "register_player", player_name)


# Callback from SceneTree.
func _player_disconnected(id):
	if has_node("/root/World"): # Game is in progress.
		if get_tree().is_network_server():
			emit_signal("game_error", "Player " + players[id] + " disconnected")
			end_game()
	else: # Game is not in progress.
		# Unregister this player.
		unregister_player(id)


# Callback from SceneTree, only for clients (not server).
func _connected_ok():
	# We just connected to a server
	emit_signal("connection_succeeded")


# Callback from SceneTree, only for clients (not server).
func _server_disconnected():
	emit_signal("game_error", "Server disconnected")
	end_game()


# Callback from SceneTree, only for clients (not server).
func _connected_fail():
	get_tree().set_network_peer(null) # Remove peer
	emit_signal("connection_failed")


# Lobby management functions.

remote func register_player(new_player_name):
	var id = get_tree().get_rpc_sender_id()
	print(id)
	players[id] = new_player_name
	emit_signal("player_list_changed")


func unregister_player(id):
	players.erase(id)
	emit_signal("player_list_changed")


remote func pre_start_game(spawn_points, player_outfits):
	#print(player_outfits)
	# Change scene.
	var world = load("res://multiplayer_modules/scenes/world.tscn").instance()
	get_tree().get_root().add_child(world)

	get_tree().get_root().get_node("Lobby").hide()

	var player_scene = load("res://multiplayer_modules/Object/player/player.tscn")

	for p_id in spawn_points:
		var spawn_pos = world.get_node("SpawnPoints/" + str(spawn_points[p_id])).position
		var player = player_scene.instance()
		
		player.set_name(str(p_id)) # Use unique ID as node name.
		player.position=spawn_pos
		player.set_outfit(player_outfits[p_id])
		player.set_network_master(p_id) #set unique id as master.

		if p_id == get_tree().get_network_unique_id():
			# If node for this peer id, set name.
			player.set_player_name(player_name)
		else:
			# Otherwise set name from peer.
			player.set_player_name(players[p_id])

		world.get_node("Object").get_node("Players").add_child(player)

	if not get_tree().is_network_server():
		# Tell server we are ready to start.
		rpc_id(1, "ready_to_start", get_tree().get_network_unique_id())
	elif players.size() == 0:
		post_start_game()


remote func post_start_game():
	get_tree().set_pause(false) # Unpause and unleash the game!


remote func ready_to_start(id):
	assert(get_tree().is_network_server())

	if not id in players_ready:
		players_ready.append(id)

	if players_ready.size() == players.size():
		for p in players:
			rpc_id(p, "post_start_game")
		post_start_game()


func host_game(new_player_name):
	player_name = new_player_name
	var host = NetworkedMultiplayerENet.new()
	host.create_server(DEFAULT_PORT, MAX_PEERS)
	get_tree().set_network_peer(host)


func join_game(ip, new_player_name):
	player_name = new_player_name
	var client = NetworkedMultiplayerENet.new()
	client.create_client(ip, DEFAULT_PORT)
	get_tree().set_network_peer(client)


func get_player_list():
	return players.values()


func get_player_name():
	return player_name


func begin_game():
	assert(get_tree().is_network_server())

	# Create a dictionary with peer id, respective spawn points and player_outfit, could be improved by randomizing.
	var spawn_points = {}
	
	spawn_points[1] = 0 # Server in spawn point 0.
	player_outfits[1] = get_current_outfit()
	
	var spawn_point_idx = 1
	for p in players:
		spawn_points[p] = spawn_point_idx
		player_outfits[p] = rpc_id(p, "request_outfit", p)
		yield(self,"outfit_added")
		spawn_point_idx += 1
		
	# Call to pre-start game with the spawn points.
	for p in players:
		rpc_id(p, "pre_start_game", spawn_points, player_outfits)
		
	pre_start_game(spawn_points, player_outfits)


func end_game():
	if has_node("/root/World"): # Game is in progress.
		# End it
		get_node("/root/World").queue_free()

	emit_signal("game_ended")
	players.clear()


func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self,"_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
