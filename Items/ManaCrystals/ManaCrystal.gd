extends Node2D

export (PackedScene) var PlusMana

onready var animatedSprite = $AnimatedSprite
onready var playerDetection = $CollisionOverlaps/PlayerDetection
onready var collectBox = $CollisionOverlaps/CollectBox

export var MAX_SPEED = 100
export var ACCELERATION = 400
export var FRICTION = 400

var velocity = Vector2.ZERO

func ready():
	animatedSprite.frame = 0
	animatedSprite.play("default")

func _physics_process(delta):
	var player = playerDetection.player
	if (player != null):
		var direction = (player.global_position - global_position).normalized()
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	global_position += velocity * delta
	
func _on_CollectBox_area_entered(area):
	PlayerStats.mana += 20
	
	var main = get_tree().current_scene
	var plusMana = PlusMana.instance()
	main.add_child(plusMana)
	plusMana.global_position = area.global_position
	queue_free()
