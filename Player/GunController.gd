extends Node2D

export (PackedScene) var Bullet
export (PackedScene) var MuzzleFlash

onready var gun = $Gun
onready var nozzle = $Nozzle
onready var firetimer = $FireTimer
onready var timer = $Timer

var is_fired_first_bullet = false
var is_firetimer_finished = true

func _ready():
	timer.wait_time = gun.fire_rate
	firetimer.wait_time = gun.fire_rate

func _fire():
	if (!is_fired_first_bullet and is_firetimer_finished):
		if (PlayerStats.mana > 0):
			fire_bullet()
			is_fired_first_bullet = true
			firetimer.start()
			is_firetimer_finished = false
	timer.start()
	
func _stop_fire():
	timer.stop()

func _on_Timer_timeout():
	if (PlayerStats.mana > 0):
		fire_bullet()
		
func fire_bullet():
	PlayerStats.mana = PlayerStats.mana - 2
	var main = get_tree().current_scene
	var bullet = Bullet.instance()
	var muzzleFlash = MuzzleFlash.instance()
		
	main.add_child(bullet)
	main.add_child(muzzleFlash)
		
	bullet.global_position = nozzle.global_position
	muzzleFlash.global_position = nozzle.global_position
		
	bullet.look_at(get_global_mouse_position())
	muzzleFlash.look_at(get_global_mouse_position())
		
	var direction = get_global_mouse_position() - global_position
	direction.normalized()
	bullet.get_direction(direction)

func _on_FireTimer_timeout():
	is_firetimer_finished = true
