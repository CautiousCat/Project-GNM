extends Area2D

func _on_GroundCastCollision_area_entered(area):
	queue_free()
