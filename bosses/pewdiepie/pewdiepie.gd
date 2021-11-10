extends Node2D


func _ready():
	Game.enemy = $Sprite
	SFX.play_music(SFX.MUSIC_PEWDIEPIE)
