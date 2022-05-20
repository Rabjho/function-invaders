extends Node


export(PackedScene) var asteroid_scene

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#func _process(delta):
#	pass

func _on_Player_Hit():
	pass # Replace with function body.

func new_game():
	score = 0
	$Player.start()
	$StartTimer.start()


func _on_AsteroidTimer_timeout():
	# Create a new instance of the Mob scene.
	var asteroid = asteroid_scene.instance()

	# Choose a random location on Path2D.
	var asteroid_spawn_location = get_node("AsteroidPath/AsteroidSpawnLocation")
	asteroid_spawn_location.offset = randi()

	# Set the asteroid's direction perpendicular to the path direction.
	var direction = asteroid_spawn_location.rotation + PI / 2

	# Set the asteroid's position to a random location.
	asteroid.position = asteroid_spawn_location.position

	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	asteroid.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	asteroid.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(asteroid)

func _on_ScoreTimer_timeout():
	score += 1

func _on_StartTimer_timeout():
	$AsteroidTimer.start()
	$ScoreTimer.start()

