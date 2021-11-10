extends Node2D

onready var tween : Tween = $Tween
onready var sprite : Sprite = $Sprite

var positions = [Vector2(8,24),Vector2(120,24)]

func _ready():
	Game.enemy = sprite
	SFX.play_music(SFX.MUSIC_ZULUL)
	start_tween()
	
	
func start_tween():
	tween.interpolate_property(sprite,"position",positions[0],positions[1],3,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	tween.start()



func _on_Tween_tween_all_completed():
	$Sprite/CoolCircle.toggle_shooting()
	positions.invert()
	start_tween()
