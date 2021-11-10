extends Generator

export var movement_speed : float = 55.0
var hit_timer : float = 0.0

onready var sprite = $Sprite

func _ready():
	Game.player = self

func _process(delta):
	hit_timer = move_toward(hit_timer,0,delta)
	sprite.modulate = Color(1,1,1,int(hit_timer<=0)*0.5+0.5)
	var hmove = Input.get_action_strength("right")-Input.get_action_strength("left")
	var vmove = Input.get_action_strength("down")-Input.get_action_strength("up")
	var dir = Vector2(hmove,vmove).normalized()
	var spd = movement_speed - 22*int(Input.is_action_pressed("slow"))
	global_position += spd*dir*delta
	global_position.x = clamp(global_position.x,0,128)
	global_position.y = clamp(global_position.y,0,124)


func _unhandled_input(event):
	if Input.is_action_just_pressed("shoot"):
		shooting = true
	if Input.is_action_just_released("shoot"):
		shooting = false

func shoot():
	var bullet = bullet_script.new()
	bullets.append(bullet)

func _process_bullets(delta):
	for bullet in bullets:
		if bullet.current_time > bullet.life_time: 
			remove_bullet(bullet)
			continue
		if processing:
			bullet._process(delta)
		if is_instance_valid(Game.enemy) and bullet.position.distance_squared_to(Game.enemy.global_position) < 80:
			Game.hit_enemy()
			remove_bullet(bullet)
			continue
	update()
