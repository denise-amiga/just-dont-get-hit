extends Node2D

var colorrect : ColorRect
var tween : Tween

func _ready():
#	margin_right = 128
#	margin_bottom = 128
	z_index = 3
	colorrect = ColorRect.new()
	colorrect.anchor_bottom = 0
	colorrect.anchor_right = 0
	colorrect.margin_bottom = 128
	colorrect.margin_right = 128
	colorrect.color = Color(1,1,1,0)
	add_child(colorrect)
	tween = Tween.new()
	add_child(tween)

func flash_screen(duration, color = Color.white):
	colorrect.color = color
	tween.interpolate_property(colorrect,"color",color,color*Color(1,1,1,0),duration)
	tween.start()
