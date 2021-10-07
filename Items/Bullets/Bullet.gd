extends Area2D

onready var timer = $Timer

export var damage = 1
export var speed = 300
export var duration = 3
export var knockback = 50

var direction = Vector2.ZERO

func _ready():
	timer.wait_time = duration

func _physics_process(delta):
	global_position += Vector2(direction * speed * delta)
	
func get_direction(dir : Vector2):
	direction = dir
	direction = direction.normalized()

func _on_Bullet_area_entered(area):
	queue_free()

func _on_Timer_timeout():
	queue_free()
