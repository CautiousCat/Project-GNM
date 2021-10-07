extends Area2D

export (PackedScene) var FireBallCircle

onready var timer = $Timer

export var damage = 1
export var speed = 300
export var duration = 3
export var fire_rate = 0.25
export var knockback = 100

var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var target_pos = Vector2.ZERO

func _ready():
	target_pos = get_global_mouse_position()
	timer.wait_time = duration

func _physics_process(delta):
	velocity = velocity.move_toward(direction * speed, speed)
	global_position += velocity * delta
	
	
func get_direction(dir : Vector2):
	direction = dir
	direction = direction.normalized()

func _on_Timer_timeout():
	queue_free()

func _on_GroundCastCollisionTarget_area_entered(area):
	var main = get_tree().get_nodes_in_group("VFX")
	var fireBallCircle = FireBallCircle.instance()
	main[0].add_child(fireBallCircle)
	fireBallCircle.global_position = global_position
	queue_free()
