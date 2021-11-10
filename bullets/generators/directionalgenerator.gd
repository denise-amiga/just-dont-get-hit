extends Generator

export var dir : Vector2
export var offset : float = 0.0
export var alt_offset : float = 0.0
export var count : int = 1

func shoot():
	for i in range(count):
		var rand = rand_range(-speed_random,speed_random)
		var pos = global_position + dir.rotated(-PI/2)*rand_range(-offset,offset) + Vector2(rand_range(-alt_offset,alt_offset),rand_range(-alt_offset,alt_offset))
		var bullet = bullet_script.new(pos,speed+rand,dir,life_time)
		add_bullet(bullet)
