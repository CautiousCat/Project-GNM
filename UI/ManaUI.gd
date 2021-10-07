extends Control

onready var ManaBar = $ManaBar

var mp : float = 100 setget set_mp
var max_mp : float = 100 setget set_max_mp

func _ready():
	self.max_mp = PlayerStats.max_mana
	self.mp = PlayerStats.mana
	PlayerStats.connect("mana_changed", self, "set_mp")
	
func set_mp(value):
	mp = clamp(value, 0, max_mp)
	ManaBar.rect_size.y = (mp/max_mp) * 96
	
func set_max_mp(value):
	max_mp = max(value, 1)
	
