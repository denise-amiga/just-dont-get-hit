extends Generator

export var rotating_speed : float = 0.5
export var rotating : bool = false
export var random : float = 0.0

func shoot():
	if is_instance_valid(Game.player):
		var angle = global_position.direction_to(Game.player.global_position).angle()
		angle += rand_range(random,-random)
		var dir = Vector2.RIGHT.rotated(angle)
		var rand = rand_range(-speed_random,speed_random)
		
		var b = bullet_script.new(global_position,speed+rand,dir,life_time)
		add_bullet(b)

