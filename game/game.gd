extends Node2D

enum BOSS {
	BILLY,
	PEWDIEPIE,
	DOC,
	ZULUL
}

const bosses = {
	BOSS.BILLY : preload("res://bosses/billy/billy.tscn"),
	BOSS.PEWDIEPIE : preload("res://bosses/pewdiepie/pewdiepie.tscn"),
	BOSS.DOC : preload("res://bosses/doc/doc.tscn"),
	BOSS.ZULUL : preload("res://bosses/zulul/zulul.tscn")
}

var player : Node2D = null
var enemy : Node2D = null

var max_health : int = 4
onready var health : int = max_health 

var enemy_max_health : float = 640
onready var enemy_health : float = enemy_max_health

const heart_full_texture : Texture = preload("res://hud/heart-full.png")
const heart_empty_texture : Texture = preload("res://hud/heart-empty.png")

const youdied : PackedScene = preload("res://hud/youdied.tscn")
const youwon : PackedScene = preload("res://hud/victory.tscn")
const finishedgame : PackedScene = preload("res://hud/finishedgame.tscn")

var tween = Tween.new()
var current_boss = BOSS.BILLY

var game_state : Dictionary

var damagerect : ColorRect = null
var game_started : bool = false

func save_game():
	var save_file = File.new()
	var err = save_file.open("user://save_file.save",save_file.WRITE)
	if err == OK:
		save_file.store_line(JSON.print(game_state))
		

func load_game():
	var save_file = File.new()
	var err = save_file.open("user://save_file.save",save_file.READ)
	if err:
		new_game()
	else:
		var json_result = JSON.parse(save_file.get_as_text())
		if json_result.error:
			new_game()
		else:
			game_state = json_result.result
			print(game_state)
	#summon_boss()

func new_game():
	game_state = {"current_boss" : 0,"kill_streak" : 0}
	save_game()

func summon_boss():
	var boss_scene = bosses[int(game_state["current_boss"])]
	enemy_health = enemy_max_health
	health = max_health
	print(boss_scene)
	get_tree().current_scene.add_child(boss_scene.instance())
	update()

func _ready():
	z_index = 1
	add_child(tween)
	update()
	load_game()
	print(game_state)


func _unhandled_input(event):
	if Input.is_action_just_pressed("restart") and is_instance_valid(enemy):
		restart()
	if Input.is_action_just_pressed("fight_next") and not is_instance_valid(enemy) and game_started: 
		restart()

func hit_player():
	health -= 1
	update()
	SFX.play_sound(load("res://sfx/player_hit.ogg"),false,0.12)
	VFX.flash_screen(0.1)
	damagerect.get_material().set_shader_param("amount",1-(health*0.33))
	if health <= 0:
		player_death()
	else:
		player.hit_timer = 1

func hit_enemy():
	enemy_health -= 1
	update()
	if enemy_health <= 0:
		enemy_death()

func enemy_death():
	VFX.flash_screen(3)
	enemy.owner.queue_free()
	if game_state["current_boss"] == BOSS.ZULUL:
		get_tree().current_scene.add_child(finishedgame.instance())
	else:
		get_tree().current_scene.add_child(youwon.instance())
	game_state["current_boss"] += 1
	game_state["current_boss"] = int(game_state["current_boss"])%(BOSS.ZULUL+1)
	game_state["kill_streak"] = max(1,game_state["kill_streak"]+1)
	save_game()
	SFX.music_player.pitch_scale = 0.3
	show_kill_streak()

func player_death():
	VFX.flash_screen(3,Color.red)
	tween.interpolate_property(Engine,"time_scale",0.2,1,0.5,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	tween.start()
	player.queue_free()
	SFX.music_player.pitch_scale = 0.8
	get_tree().current_scene.add_child(youdied.instance())
	Engine.time_scale = 0.5
	game_state["kill_streak"] = min(-1,game_state["kill_streak"]-1)
	show_kill_streak()
	save_game()

func show_kill_streak():
	var canvaslayer = CanvasLayer.new()
	canvaslayer.layer = 100
	add_child(canvaslayer)
	var tween = Tween.new()
	canvaslayer.add_child(tween)
	var label = Label.new()
	tween.add_child(label)
	label.text = ("Kill Streak: " if game_state["kill_streak"] > 0 else "Death Count: ")+ str(abs(game_state["kill_streak"]))
	tween.interpolate_property(label,"modulate",Color.white,Color(1.0,1.0,1.0,0.0),1.0)
	tween.start()
	tween.connect("tween_all_completed",canvaslayer,"queue_free")
	label.align = Label.ALIGN_CENTER
	label.valign = Label.VALIGN_CENTER
	label.margin_right = 128
	label.margin_bottom = 128
	label.theme = preload("res://menu/themes/maintheme.tres")

func restart():
	get_tree().reload_current_scene()
	health = max_health
	enemy_health = enemy_max_health
	SFX.music_player.pitch_scale = 1
	Engine.time_scale = 1
	tween.stop_all()
	damagerect.get_material().set_shader_param("amount",0.0)
	update()

func _draw():
	if is_instance_valid(Game.player):
		_draw_health()
	if is_instance_valid(Game.enemy):
		_draw_enemy_health()

func _draw_health():
	var j = 0
	for i in health:
		draw_texture(heart_full_texture,Vector2(j*14,0))
		j+=1
	for i in clamp(max_health-health,0,max_health):
		draw_texture(heart_empty_texture,Vector2(j*14,0))
		j+=1

func _draw_enemy_health():
	draw_rect(Rect2(0,124,128,4),Color.black,true)
	draw_rect(Rect2(0,124,128*enemy_health/enemy_max_health,4),Color.red,true)
