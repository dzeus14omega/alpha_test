extends Control

var total_character
var setting_state

enum State{
	open,
	close
}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	setting_state = State.close
	total_character = 4
	$AnimationPlayer.play("start_menu")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Increase_pressed():
	if (total_character < 14):
		total_character += 1
		$menu_single_game/VBoxContainer/HBoxContainer/num_character.text = str(total_character)
	pass # Replace with function body.


func _on_decrease_pressed():
	if (total_character > 4):
		total_character -= 1
		$menu_single_game/VBoxContainer/HBoxContainer/num_character.text = str(total_character)
	pass # Replace with function body.


func _on_New_Game_pressed():
	if(setting_state == State.open):
		$AnimationPlayer.play_backwards("Setting_box")
		setting_state = State.close
		yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play_backwards("start_menu")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("single_mode")
	pass # Replace with function body.


func _on_back_to_mainMenu_pressed():
	$AnimationPlayer.play_backwards("single_mode")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("start_menu")
	pass # Replace with function body.


func _on_setting_pressed():
	if (setting_state == State.close):
		$AnimationPlayer.play("Setting_box")
		setting_state = State.open
	pass # Replace with function body.


func _on_Start_pressed():
	var amount = int($menu_single_game/VBoxContainer/HBoxContainer/num_character.text)
	#print(amount)
	GLOBAL.update_total_character(amount)
	get_tree().change_scene("res://scenes/main_scene.tscn")
	pass # Replace with function body.


func _on_multiplayer_pressed():
	get_tree().change_scene("res://multiplayer_modules/scenes/lobby.tscn")
	pass # Replace with function body.
