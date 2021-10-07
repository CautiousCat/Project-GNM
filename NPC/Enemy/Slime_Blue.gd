extends KinematicBody2D

onready var softCollision = $CollisionOverlaps/SoftCollision
onready var hurtbox = $CollisionOverlaps/HurtBox
onready var hitbox = $CollisionOverlaps/Hitbox
onready var playerDetection = $CollisionOverlaps/PlayerDetection
onready var animatedSprite = $AnimatedSprite
onready var stats = $Stats

export (PackedScene) var DeathEffect

enum {IDLE, WANDER, CHASE}

export var FRICTION = 200
export var MAX_SPEED = 50
export var ACCELERATION = 300
export var DAMAGE = 1

var knockback = Vector2.ZERO
var velocity = Vector2.ZERO

var state = IDLE

func _ready():
	hitbox.set_damage(DAMAGE)

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			animatedSprite.play("Idle")
			seek_player()
		WANDER:
			pass
		CHASE:
			animatedSprite.play("Chase")
			var player = playerDetection.player
			if (player != null):
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
			animatedSprite.flip_h = velocity.x < 0
	
	if (softCollision.is_colliding()):
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetection.can_see_player():
		state = CHASE

func pick_rand_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_HurtBox_area_entered(area):
	stats.health = stats.health - area.damage
	knockback = Vector2(global_position - area.global_position).normalized() * area.knockback

func _on_Stats_no_health():
	var main = get_tree().current_scene
	var deathEffect = DeathEffect.instance()
	main.add_child(deathEffect)
	deathEffect.global_position = global_position
	queue_free()
