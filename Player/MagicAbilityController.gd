extends Node2D

export (PackedScene) var MagicAbility
export (PackedScene) var GroundCastCollision

onready var magicCaster = $MagicCaster
onready var castpoint = $CastPoint
onready var firetimer = $FireTimer
onready var timer = $Timer

var is_fired_first_magic = false
var is_firetimer_finished = true

func _ready():
	timer.wait_time = magicCaster.fire_rate
	firetimer.wait_time = magicCaster.fire_rate

func _fire():
	if (!is_fired_first_magic and is_firetimer_finished):
		if (PlayerStats.mana > 0 and (PlayerStats.mana - 10) >= 0):
			fire_magic()
			is_fired_first_magic = true
			firetimer.start()
			is_firetimer_finished = false
	timer.start()
	
func _stop_magic():
	timer.stop()

func _on_Timer_timeout():
	if (PlayerStats.mana > 0 and (PlayerStats.mana - 10) >= 0):
		fire_magic()
		
func fire_magic():
	PlayerStats.mana = PlayerStats.mana - 10
	var main = get_tree().current_scene
	var magicAbility = MagicAbility.instance()
	var groundCastCollision = GroundCastCollision.instance()
		
	main.add_child(magicAbility)
	main.add_child(groundCastCollision)
		
	magicAbility.global_position = castpoint.global_position
	groundCastCollision.global_position = get_global_mouse_position()
		
	magicAbility.look_at(get_global_mouse_position())
		
	var direction = get_global_mouse_position() - global_position
	direction.normalized()
	magicAbility.get_direction(direction)

func _on_FireTimer_timeout():
	is_firetimer_finished = true
