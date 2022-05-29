extends Node


export(PackedScene) var asteroid_scene

export(AudioStream) var menu_music
export(AudioStream) var game_overMusic
export(AudioStream) var one_life
export(AudioStream) var two_lives
export(AudioStream) var three_lives


var score
var lives
var lives_lost
var gamedata
var highscore
var score_offset = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$MusicController.volume_db = -8

func new_game():
	get_tree().call_group("asteroids", "queue_free")
	score = 0
	lives = 3
	lives_lost = 0
	$Player.start()
	$StartTimer.start()
	$AsteroidTimer.set_paused(false)
	$AsteroidTimer.wait_time = 2
	$HUD.start_message("Get Ready")
	$MusicController.volume_db = -10
	$MusicController.stream = three_lives
	$MusicController.play()
	$HUD.update_lives(lives)
	$HUD.update_score(score)


func _on_AsteroidTimer_timeout():
	var asteroid = asteroid_scene.instance()
	$Asteroids.add_child(asteroid)
	asteroid.connect("score", self, "_update_score")
	asteroid.connect("player_hit", self, "_on_Player_hit")

func _on_StartTimer_timeout():
	$AsteroidTimer.start()

func _on_Player_hit():
	lives -= 1
	lives_lost += 1
	if (lives == 0):
		game_over()
	elif (lives == 2):
		$MusicController.volume_db = -6
		$MusicController.stream = two_lives
		$MusicController.play()
	elif (lives == 1):
		$MusicController.volume_db = -12
		$MusicController.stream = one_life
		$MusicController.play()
	
	$HUD.update_lives(lives)
	score_offset = score
	_update_difficulty()

func _update_difficulty():
	$AsteroidTimer.wait_time = clamp(2 * pow(0.9, score - score_offset), 0.6, INF)
	print($AsteroidTimer.wait_time)

func game_over():
	$MusicController.stream = game_overMusic
	$MusicController.volume_db = -8
	$MusicController.play()
	$AsteroidTimer.set_paused(true)
	get_tree().call_group("asteroids", "queue_free")
	get_tree().call_group("bullets", "queue_free")

	$Player.game_over()
	highscore = _get_score()
	if (score > highscore):
		_save_score(score)
	$HUD.game_over(score, highscore)

func _update_score():
	score += 1
	$HUD.update_score(score)
	_update_difficulty()


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

