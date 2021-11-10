extends Control

func _ready():
	SFX.play_music(SFX.MUSIC_MAIN)
	if int(Game.game_state["kill_streak"]) == 0:
		$Buttons/Continue.visible = false
		$Buttons/NewGame.grab_focus()
	else:
		$Buttons/Continue.grab_focus()
	Game.game_started = false

func _on_Play_pressed():
	Game.new_game()
	get_tree().change_scene("res://world/World.tscn")


func _on_Continue_pressed():
	get_tree().change_scene("res://world/World.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Continue_mouse_entered():
	$Buttons/Continue.grab_focus()


func _on_NewGame_mouse_entered():
	$Buttons/NewGame.grab_focus()


func _on_Quit_mouse_entered():
	$Buttons/Quit.grab_focus()
