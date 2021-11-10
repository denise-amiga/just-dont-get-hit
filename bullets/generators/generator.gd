extends Node2D
class_name Generator


var bullets = []
export var shots_per_second : float = 0.5
export var rotation_speed : float = 1.0
export var speed : float = 100.0
export var speed_random : float = 0.0
export var life_time : float = 3.0
var timer : float
export var processing : bool = true
export var shooting : bool = true
export var update_rand : float = 0.0
export var bullet_script : Script = Bullet

func toggle_shooting():
	shooting = !shooting
	timer = 1


func _process(delta):
	_process_bullets(delta)
	if shooting:
		timer += delta*shots_per_second
		if timer > 1:
			timer -= 1
			shoot()


func _process_bullets(delta):
	for bullet in bullets:
		if bullet.current_time > bullet.life_time: 
			remove_bullet(bullet)
			continue
		if processing:
			bullet._process(delta)
		if is_instance_valid(Game.player) and bullet.position.distance_squared_to(Game.player.global_position) < bullet.radius_squared and Game.player.hit_timer <= 0:
			Game.hit_player()
			remove_bullet(bullet)
			break
	if rand_range(0,100)>=update_rand: update()

func add_bullet(bullet):
	bullets.append(bullet)

func remove_bullet(bullet):
	bullets.erase(bullet)
	
func shoot():
	pass 

func _draw():
	_draw_bullets()
	
func _draw_bullets():
	var delta = get_physics_process_delta_time()
	for bullet in bullets:
		if bullet.current_time > bullet.life_time: continue
		var rect = Rect2()
		rect.size = bullet.size
		rect.position = Vector2()
		var srcrect = bullet.get_srcrect()
		var pos = bullet.position
		var rotation = bullet.rotation
		pos.x -= 0
#		pos.x += x_offset
#		pos.y += y_offset
		if Rect2(-20,-20,160,160).has_point(bullet.position):
			draw_set_transform(pos - rect.size.rotated(rotation)/2-global_position,rotation,bullet.scale)
			var mod = Color.white if processing else Color(0.7,0.7,0.7,1.0)
			draw_texture_rect_region(bullet.texture,rect,srcrect,mod)
			draw_set_transform(Vector2(),0,Vector2(1,1))
