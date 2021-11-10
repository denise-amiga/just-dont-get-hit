extends Generator


export var dir = 1

var time = 0.0
export var wave_speed : float = 2.0
export var wave_rand : float = 4.0
export var dist : float = 16.0
export var row_count : int = 20
export var amplitude : float = 1.0
export var vertical : bool = false

var step : int = 0

func _process(delta):
	time = fmod(time+delta*wave_speed,TAU)

func shoot():
	var ypos = (((sin(time)+1)/2.0-0.5)*amplitude)*64.0+64
	for i in range(row_count+1):
		var y = i*128.0/row_count+gwr()
		if abs(y-ypos) > dist:
			var x = 65-75*dir+gwr()
			var pos = Vector2(x,y) if not vertical else Vector2(y,x)
			var rand = rand_range(-speed_random,speed_random)
			var bullet = bullet_script.new(pos,speed+rand,(Vector2.RIGHT if not vertical else Vector2.DOWN)*dir,life_time)
			add_bullet(bullet)

func gwr():
	return rand_range(-wave_rand,wave_rand)
