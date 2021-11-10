extends Bullet

export var gravity : float = 160

export var max_falling_speed : float = 50

func _init(position,speed,direction,life_time).(position,speed,direction,life_time):
	texture = preload("res://bosses/zulul/poopoo.png")
	animation_speed = 1
	frame_count = 1
	size = Vector2(5,5)

func _process(delta):
	._process(delta)
	var velocity = speed*direction
	velocity.y = min(velocity.y+gravity*delta,max_falling_speed)
	speed = velocity.length()
	rotation = velocity.angle() - PI/2
	direction = Vector2.RIGHT.rotated(rotation+PI/2)
