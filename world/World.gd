extends Node2D

func _ready():
	Game.summon_boss()
	Game.game_started = true

func _unhandled_input(event):
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene("res://menu/startmenu/startmenu.tscn")
		Game.update()
