extends Control

onready var healthBar = $HealthBar

var hp : float = 5 setget set_hp
var max_hp : float = 5 setget set_max_hp

func _ready():
	self.max_hp = PlayerStats.max_health
	self.hp = PlayerStats.health
	PlayerStats.connect("health_changed", self, "set_hp")

func set_hp(value):
	hp = clamp(value, 0, max_hp)
	if (healthBar != null):
		healthBar.rect_size.x = (hp/max_hp) * 118 
	 
func set_max_hp(value):
	max_hp = max(value, 1)
	

	
