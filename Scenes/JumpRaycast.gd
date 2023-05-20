extends RayCast2D


func _process(_delta):
	global_rotation_degrees = 0


func can_jump():
	return is_colliding() and (get_collider() is TileMap)
