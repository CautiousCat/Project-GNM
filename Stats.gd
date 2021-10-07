extends Node

export var max_health : float = 5
export var max_mana : float = 100

onready var health : float = max_health setget set_health
onready var mana : float = max_mana setget set_mana

signal no_health
signal health_changed(value)
signal mana_changed(value)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if (health <= 0):
		emit_signal("no_health")
		
func set_mana(value):
	mana = value
	if mana > max_mana:
		mana = max_mana
	emit_signal("mana_changed", mana)




