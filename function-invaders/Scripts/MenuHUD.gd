extends CanvasLayer

signal start_game

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start_message(text):
	$StartButton.hide()
	$StartMessage.show()
	$StartMessage.text = text
	$StartTimer.start()
	$TitleLabel.hide()
	$EndMessage.hide()
	$GameOverHighscore.hide()
	$GameOverScore.hide()

func update_score(score):
	$ScoreLabel.text = "SCORE: " + str(score)

func update_type(type):
	$FunctionLabel.text = "Latest type: " + str(type)

func update_lives(lives):
	$LivesLabel.text = "LIVES: " + str(lives)

func game_over(score, highscore):
	$FunctionLabel.hide()
	$ScoreLabel.hide()
	$LivesLabel.hide()
	$GameOverScore.show()
	$GameOverScore.bbcode_text = "Score: " + str(score)
	$GameOverHighscore.show()
	$GameOverHighscore.bbcode_text = "Highscore: " + str(highscore)
	$EndMessage.show()
	if (score > highscore):
		$EndMessage.bbcode_text = "[center]%s[/center]" % "You beat the highscore ggwp"
	elif (score == highscore):
		$EndMessage.bbcode_text = "[center]%s[/center]" % "You matched the highscore!"
	else:
		$EndMessage.bbcode_text = "[center]%s[/center]" % "Better luck next time!"
	$StartButton.show()
	$StartButton.text = "Restart the game"
		
func _on_StartTimer_timeout():
	$StartMessage.hide()
	$ScoreLabel.show()
	$FunctionLabel.show()
	$LivesLabel.show()
	

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
