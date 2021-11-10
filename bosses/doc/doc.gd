extends Node2D

func _ready():
	Game.enemy = get_node("Sprite")
	SFX.play_music(SFX.MUSIC_DOC)
