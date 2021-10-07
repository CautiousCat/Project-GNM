extends Node2D

export (PackedScene) var ManaCrystal

onready var animatedSprite = $AnimatedSprite

func _ready():
	animatedSprite.frame = 0
	animatedSprite.play("default")

func _on_AnimatedSprite_animation_finished():
	var main = get_tree().current_scene
	var manaCrystal = ManaCrystal.instance()
	main.add_child(manaCrystal)
	manaCrystal.global_position = global_position
	queue_free()
