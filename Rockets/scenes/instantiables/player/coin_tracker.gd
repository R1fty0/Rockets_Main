extends Area2D


const _MAX_DIST := INF


func _process(_delta: float) -> void:
	var coin := get_closest_coin()
	
	if coin == null:
		return
	
	var angle := global_position.angle_to_point(coin.global_position)
	global_rotation = angle


func get_closest_coin() -> Area2D:
	var closest_coin: Area2D
	var closest_dist := _MAX_DIST
	
	for coin in get_tree().get_nodes_in_group(&"coins"):
		var coin_pos: Vector2 = coin.global_position
		var player_pos: Vector2 = get_parent().global_position
		var dist := coin_pos.distance_to(player_pos)
		if dist < closest_dist:
			closest_dist = dist
			closest_coin = coin
	
	return closest_coin
