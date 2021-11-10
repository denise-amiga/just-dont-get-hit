extends "res://bullets/generators/coolcircle.gd"

func shoot():
	for j in range(3):
		for i in range(count):
			var bullet = bullet_script.new(global_position,speed/(j+1),Vector2.RIGHT.rotated(angle+i*TAU/(count)+j*0.5),life_time)
			add_bullet(bullet)
