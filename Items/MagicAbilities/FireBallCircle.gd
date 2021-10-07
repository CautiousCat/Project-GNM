extends Area2D

onready var timer = $Timer
onready var tickDamageTimer = $TickDamageTimer

export var damage = 1
export var knockback = 0

var can_damage = true
var enemy = null

func _ready():
	timer.start()

func _physics_process(delta):
	if (can_damage && enemy != null):
		enemy.stats.health -= 2
		can_damage = false

func _on_Timer_timeout():
	queue_free()

func _on_FireBallCircle_body_entered(body):
	tickDamageTimer.start()
	enemy = body
	
func _on_TickDamageTimer_timeout():
	can_damage = true

func _on_FireBallCircle_body_exited(body):
	enemy = null
