extends Bullet

export var delay : float = 0.5
var rot_dir : float
var rot_speed : float

func _init(position,speed,direction,life_time).(position,speed,direction,life_time):
	texture = preload("res://bosses/pewdiepie/cmonbruh.png")
	animation_speed = 1
	frame_count = 1
	size = Vector2(6,6)
	rot_dir = (randi()%2*2)-1
	rot_speed = rand_range(5,8)
	self.speed/=10
	pass

func _process(delta):
	._process(delta)
	if position.x < 0: direction = direction.bounce(Vector2.RIGHT)
	elif position.x > 128: direction = direction.bounce(Vector2.LEFT)
	elif position.y < 0: direction = direction.bounce(Vector2.DOWN)
	#elif position.y > 128: direction = direction.bounce(Vector2.UP)
	rotation = fmod(rotation+rot_dir*delta*rot_speed,TAU)
	delay -= delta
	if delay <= 0:
		speed *= 10
		delay = life_time
	
