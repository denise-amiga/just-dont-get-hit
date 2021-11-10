extends Bullet

export var homing_rotation_speed : float = 0.4


func _init(position,speed,direction,life_time).(position,speed,direction,life_time):
	texture = preload("res://bosses/doc/cd.png")
	size = Vector2(5,5)
	frame_count = 1
	animation_speed = 1

func _process(delta):
	._process(delta)
	if is_instance_valid(Game.player):
		var dangle = direction.angle()
		var s = sign(angle_to_angle(dangle,position.direction_to(Game.player.global_position).angle()))
		direction = direction.rotated(s*homing_rotation_speed*delta)
		
static func angle_to_angle(from, to):
	return fposmod(to-from + PI, PI*2) - PI
