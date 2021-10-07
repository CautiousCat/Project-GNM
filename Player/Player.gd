extends KinematicBody2D

onready var animationPlayer = $Animation/AnimationPlayer
onready var animationTree = $Animation/AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var hurtbox = $CollisionOverlaps/HurtBox
onready var gunController = $GunController
onready var magicAbilityController = $MagicAbilityController

export var MAX_SPEED = 100
export var ACCELERATION = 800
export var FRICTION = 800

var vector_input = Vector2.ZERO
var velocity = Vector2.ZERO

func _ready():
	PlayerStats.connect("no_health", self, "_on_PlayerStats_no_health")

func _physics_process(delta):
	vector_input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	vector_input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	vector_input = vector_input.normalized()
	
	if (vector_input != Vector2.ZERO):
		animationTree.set("parameters/Idle/blend_position", vector_input)
		animationTree.set("parameters/Walk/blend_position", vector_input)
		velocity = velocity.move_toward(vector_input * MAX_SPEED, ACCELERATION * delta)
		animationState.travel("Walk")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		animationState.travel("Idle")
		
	gunController.look_at(get_global_mouse_position())
	magicAbilityController.look_at(get_global_mouse_position())
# warning-ignore:return_value_discarded
	move_and_slide(velocity)

func _input(event):
	if (event.get_action_strength("shoot")):
		gunController._fire()
		gunController.is_fired_first_bullet = false
	elif (event.is_action_released("shoot")):
		gunController._stop_fire()
	
	if (event.get_action_strength("shoot_magic")):
		magicAbilityController._fire()
		magicAbilityController.is_fired_first_magic = false
	elif (event.is_action_released("shoot_magic")):
		magicAbilityController._stop_magic()

func _on_HurtBox_area_entered(area):
	PlayerStats.health = PlayerStats.health - area.damage

func _on_PlayerStats_no_health():
	queue_free()
