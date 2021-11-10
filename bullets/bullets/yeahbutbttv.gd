extends Bullet

export var delay = 1.0

func _init(position,speed,direction,life_time).(position,speed,direction,life_time):
	texture = preload("res://bosses/doc/yeahbutbttv.png")
	animation_speed = 0.05
	frame_count = 24
	size = Vector2(10,10)
	radius_squared = 16
	
func _process(delta):
	._process(delta)
	delay -= delta
	if delay < 0 and is_instance_valid(Game.player):
		direction = position.direction_to(Game.player.global_position)
		delay = life_time

	
