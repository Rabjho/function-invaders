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

func update_score(score):
	$ScoreLabel.text = "SCORE: " + str(score)

func update_type(type):
	$FunctionLabel.text = "Latest type: " + str(type)

func update_lives(lives):
	$LivesLabel.text = "LIVES: " + str(lives)

func game_over(score):
	$FunctionLabel.hide()
	$ScoreLabel.hide()
	$LivesLabel.hide()



func _on_StartTimer_timeout():
	$StartMessage.hide()
	$ScoreLabel.show()
	$FunctionLabel.show()
	$LivesLabel.show()
	

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
