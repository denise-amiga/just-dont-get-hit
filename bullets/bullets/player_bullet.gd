extends Bullet

func _init().(Game.player.global_position,300.0,Vector2.UP,1.0):
	texture = preload("res://bullets/bullets/player_bullet.png")
	animation_speed = 1
	frame_count = 1
	size = Vector2(1,1)
