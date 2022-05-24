extends RigidBody2D


export(float) var speed = 400
var type
var screenSize
var startPos
var endPos
var a
var b
var c
var d



# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport().size
	$AnimatedSprite.frame = randi() % $AnimatedSprite.frames.get_frame_count($AnimatedSprite.animation)
	type = randi() % 1
	startPos = Vector2(0, randi() % int(screenSize.y))
	endPos = Vector2 (screenSize.x, randi() % int(screenSize.y))
	position = startPos
	if (type == 0):
		b = startPos.y
		a = (endPos.y - b) / endPos.x
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * delta
	
	if (type == 0):
		position.y = a * position.x + b	

	
