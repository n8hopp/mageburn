extends Area2D

var skeleton = preload("res://scenes/enemies/skeleton.tscn")

@onready var playable_area = find_child("CollisionShape2D").shape.size

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer1.start()
	$Timer2.start()
	$Timer3.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_1_timeout():
	instance_new_enemy()
	print("Enemy incoming!")

func _on_timer_2_timeout():
	for x in range(1,10):
		instance_new_enemy()
	print("Wave incoming!!")

func _on_timer_3_timeout():
	for x in range(1, 50):
		instance_new_enemy()
	print("Tsunami incoming!!!")


# find valid position to spawn enemy, then spawn it.
# if it fails to find a valid location 10 times: give up
func instance_new_enemy():
	# create an enemy obj and get its size
	var enemy = skeleton.instantiate()
	var enemy_size = enemy.find_child("Sprite2D").find_child("Hurtbox").find_child("CollisionShape2D").shape.size
	
	var failed_to_spawn_counter = 0
	var spawned_enemy = false
	while spawned_enemy == false and failed_to_spawn_counter < 10:
		# choose a random point in the playable area
		# (referenced to center of EnemyManager's CollisionShape2D)
		var randx = randf_range( -playable_area.x/2, playable_area.x/2 )
		var randy = randf_range( -playable_area.y/2, playable_area.y/2 )
		
		# ensure enemy spawns entirely within the boundry
		# left boundry
		if randx < enemy_size.x/2:
			randx += enemy_size.x/2
		# top boundry
		if randy < enemy_size.y/2:
			randy += enemy_size.y/2
		# right boundry
		if randx > playable_area.x/2 + enemy_size.x/2:
			randx -= enemy_size.x/2
		# bottom boundry
		if randy > playable_area.y/2 + enemy_size.y/2:
			randy -= enemy_size.y/2
		
		# get the global coordinates for the enemy
		enemy.global_position.x = global_position.x + randx
		enemy.global_position.y = global_position.y + randy
		enemy.z_index = 1
		
		# check if enemy location is too close to player
		var player = PlayerVariables.follow_target
		var player_pos = player.global_position
		enemy.follow_target = player
		if enemy.global_position.distance_to(player_pos) >= (16*10) and player.visible == true:
			get_tree().current_scene.add_child(enemy)
			#print("spawned an enemy")
			spawned_enemy = true
		else:
			failed_to_spawn_counter += 1
			#print("failed to spawn an enemy")
