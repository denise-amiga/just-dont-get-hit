class_name Bullet

var position : Vector2
var speed : float
var life_time : float
var current_time : float
var direction : Vector2
var rotation : float
var scale : Vector2 = Vector2(1,1)
var size : Vector2 = Vector2(4,8)
var radius_squared : float = 12

var animation_speed : float = 0.2
var frame_count : int = 3

var texture = preload("res://bullets/bullets/bullet-sheet.png")

func _init(position,speed,direction,life_time):
	self.position = position
	self.speed = speed
	self.direction = direction
	self.life_time = life_time
	rotation = direction.angle() - PI/2

func _process(delta):
	position += delta*speed*direction
	current_time += delta

func get_srcrect():
	var current_frame = int(current_time/animation_speed)%frame_count
	return Rect2(Vector2(current_frame*texture.get_size().x/frame_count,0),texture.get_size()/Vector2(frame_count,1))
