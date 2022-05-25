extends Node


export(PackedScene) var asteroid_scene
export(AudioStream) var menu_music
export(AudioStream) var game_overMusic
export(AudioStream) var one_life
export(AudioStream) var two_lives
export(AudioStream) var three_lives


var score
var lives
var gamedata
var highscore

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func new_game():
	score = 0
	lives = 3
	get_tree().call_group("asteroids", "queue_free")
	$Player.start()
	$StartTimer.start()
	$AsteroidTimer.set_paused(false)
	$HUD.start_message("Get Ready")
	$MusicController.stream = three_lives
	$MusicController.play()
	$HUD.update_lives(lives)


func _on_AsteroidTimer_timeout():
	var asteroid = asteroid_scene.instance()
	$Asteroids.add_child(asteroid)
	asteroid.connect("score", self, "_update_score")

func _on_StartTimer_timeout():
	$AsteroidTimer.start()

func _on_Player_hit():
	lives -= 1
	if (lives == 0):
		game_over()
	elif (lives == 2):
		$MusicController.stream = two_lives
		$MusicController.play()
	elif (lives == 1):
		$MusicController.stream = one_life
		$MusicController.play()
	
	$HUD.update_lives(lives)

func game_over():
	$MusicController.stream = game_overMusic
	$MusicController.play()
	$AsteroidTimer.set_paused(true)
	get_tree().call_group("asteroids", "queue_free")
	$Player.game_over()
	highscore = _get_score()
	if (score > highscore):
		_save_score(score)
	$HUD.game_over(score, highscore)

func _update_score():
	score += 1
	$HUD.update_score(score)



var score_file = "user://game.dat"
func _save_score(n):    
	var file = File.new()
	file.open(score_file, File.WRITE)
	file.store_var(n)
	file.close()
	
func _get_score():
	var file = File.new()
	if file.file_exists(score_file):
		file.open(score_file, File.READ)
		var temp = file.get_var()
		file.close()
		return temp
	else:
		return 0
