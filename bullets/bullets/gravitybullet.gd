extends Bullet
class_name GravityBullet

export var gravity : float = 120

func _init(position,speed,direction,life_time).(position,speed,direction,life_time):
	pass

func _process(delta):
	._process(delta)
	var velocity = speed*direction
	velocity.y += gravity*delta
	speed = velocity.length()
	rotation = velocity.angle() - PI/2
	direction = Vector2.RIGHT.rotated(rotation+PI/2)
	
