extends Node2D

onready var timer = $Timer

export var SPEED = 20

func _ready():
	timer.start()

func _physics_process(delta):
	global_position += Vector2.UP * SPEED * delta

func _on_Timer_timeout():
	queue_free()
