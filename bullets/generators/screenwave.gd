extends Generator

export var wave_speed : float = 2.0
export var dir = 1
export var vertical : bool = false

export var time : float = 0.0

func _process(delta):
	if shooting:
		time += delta

func shoot():
	var pos 
	if not vertical: pos = Vector2(65-75*dir,(sin(time*wave_speed)+1)*64)
	else: pos = Vector2((sin(time*wave_speed)+1)*64,65+75*dir)
	var rand = rand_range(-speed_random,speed_random)
	var bullet = bullet_script.new(pos,speed+rand,(Vector2.RIGHT if not vertical else Vector2.UP)*dir,life_time)
	add_bullet(bullet)
