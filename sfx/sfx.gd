extends Node2D

enum {
	MUSIC_MAIN,
	MUSIC_BILLY,
	MUSIC_PEWDIEPIE,
	MUSIC_DOC,
	MUSIC_ZULUL
}

const MUSIC = {
	MUSIC_MAIN : {
		"name" : "DJ FGT ft. forsen - Don't Doubt",
		"file" : preload("res://sfx/music/doubt1.ogg")
	},
	MUSIC_BILLY : {
		"name" : "official sony music entertainment - Un (male symbol)wen Was Her",
		"file" : preload("res://sfx/music/touhou1.ogg")
	},
	MUSIC_PEWDIEPIE : {
		"name" : "Party in Backyard ft. PewDiePie - Hej Monika",	
		"file" : preload("res://sfx/music/pewdiepie1.ogg")
	},
	MUSIC_DOC : {
		"name" : "Sung - Thunder Love",
		"file" : preload("res://sfx/music/doc1.ogg")
	},
	MUSIC_ZULUL : {
		"name":"TerribleTerrio - GWA GWA GWAthletic theme from yoshi island",
		"file" : preload("res://sfx/music/zulul1.ogg")
	}
}

var music_player : AudioStreamPlayer
var current_music : int = -1

var now_playing : Tween

func play_music(music):
	if current_music == music: return
	current_music = music
	music_player.stream = MUSIC[music]["file"]
	music_player.play(0.0)
	now_playing(MUSIC[music]["name"])

func now_playing(string):
	if is_instance_valid(now_playing): now_playing.get_parent().queue_free()
	var canvaslayer = CanvasLayer.new()
	canvaslayer.layer = 100
	add_child(canvaslayer)
	now_playing = Tween.new()
	canvaslayer.add_child(now_playing)
	var label = Label.new()
	label.theme = preload("res://menu/themes/maintheme.tres")
	now_playing.add_child(label)
	now_playing.connect("tween_all_completed",canvaslayer,"queue_free")
	now_playing.interpolate_property(label,"rect_position",Vector2(138,112),Vector2(-800,112),10.0)
	now_playing.start()
	#label.rect_scale = Vector2(0.666,0.666)
	label.modulate = Color(1,1,1,0.5)
	label.text = "Now Playing: " + string

func _ready():
	music_player = AudioStreamPlayer.new()
	music_player.name = "MusicPlayer"
	music_player.bus = "Music"
	add_child(music_player)

func play_sound(sound : AudioStream,loop : bool = false,start_time : float = 0.0,volume : float = 0.0):
	var splayer = AudioStreamPlayer.new()
	add_child(splayer)
	splayer.connect("finished",splayer,"queue_free")
	splayer.stream = sound
	splayer.stream.loop = false
	splayer.volume_db = volume
	splayer.bus = "Sound"
	splayer.play(start_time)
	return splayer

func _unhandled_input(event):
	if Input.is_action_just_pressed("volume_up"):
		var bus_index = AudioServer.get_bus_index("Master")
		var bus_volume = AudioServer.get_bus_volume_db(bus_index)
		AudioServer.set_bus_volume_db(bus_index,bus_volume+6.0)
	if Input.is_action_just_pressed("volume_down"):
		var bus_index = AudioServer.get_bus_index("Master")
		var bus_volume = AudioServer.get_bus_volume_db(bus_index)
		AudioServer.set_bus_volume_db(bus_index,bus_volume-6.0)
