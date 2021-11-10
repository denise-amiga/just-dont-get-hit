extends Generator

export var count : int = 5
export var angle : float = 0.0
export var random : float = 0.0

func _process(delta):
	if shooting:
		angle += rotation_speed*delta

func shoot():
	for i in range(count):
		var a = angle+i*TAU/count + rand_range(-random,random)
		var rand = rand_range(-speed_random,speed_random)
		var bullet = bullet_script.new(global_position,speed+rand,Vector2.RIGHT.rotated(a),life_time)
		add_bullet(bullet)
