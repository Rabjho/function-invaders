extends Node


export(PackedScene) var asteroid_scene
export(AudioStream) var menu_music
export(AudioStream) var game_over
export(AudioStream) var one_life
export(AudioStream) var two_lives
export(AudioStream) var three_lives


var score
var lives

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#func _process(delta):
#	pass

func new_game():
	score = 0
	lives = 3
	$Player.start()
	$StartTimer.start()
	$HUD.start_message("Get Ready")
	$MusicController.stream = three_lives
	$MusicController.play()

func _on_AsteroidTimer_timeout():
	add_child(asteroid_scene.instance())


func _on_StartTimer_timeout():
	$AsteroidTimer.start()

func _on_Player_hit():
	lives -= 1
	pass # Replace with function body.
