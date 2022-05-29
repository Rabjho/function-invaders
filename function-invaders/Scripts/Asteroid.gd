extends RigidBody2D

export(PackedScene) var explosion_scene

export(float) var speed = 400
var type
var screenSize
var startPos
var endPos
var a
var b
var c
var d
signal score
signal player_hit

const e = 2.7182818284590452353602874713527

# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport().size
	$AnimatedSprite.frame = randi() % $AnimatedSprite.frames.get_frame_count($AnimatedSprite.animation)
	type = randi() % 4
	startPos = Vector2(0, rand_range(0.00000001, screenSize.y))
	endPos = Vector2(screenSize.x, rand_range(0.00000001, screenSize.y))
	position = startPos



	if (type == 0):
		b = startPos.y
		a = (endPos.y - b) / endPos.x
	if (type == 1):
		c = startPos.y
		a = (endPos.y - startPos.y) / (endPos.x * (endPos.x - startPos.x))
		b = -a * startPos.x
	if (type == 2):
		b = startPos.y
		a = pow(e,log(endPos.y / startPos.y) / endPos.x)
	if (type == 3):
		var ampFraction = 10
		var freqFraction = 400000

		a = rand_range(screenSize.y * 1 / ampFraction, screenSize.y / 4)
		b = rand_range(screenSize.x * 1 / freqFraction, screenSize.x * 3 / freqFraction)
		c = rand_range(0, 2 * PI)
		d = rand_range(a, screenSize.y - a)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * delta
	
	if (type == 0):
		position.y = a * position.x + b	
	if (type == 1):
		position.y = a * pow(position.x, 2) + b * position.x + c
	if (type == 2):
		position.y = b * pow(a, position.x)
	if (type == 3):
		position.y = a * sin(b * position.x - c) + d
	

func _on_Asteroid_body_entered(body):
	if ("bullets" in body.get_groups()):
		emit_signal("score")
		_explode()
		body.queue_free()
	if ("player" in body.get_groups()):
		emit_signal("player_hit")
		_explode()


func _explode():
	var explosion = explosion_scene.instance()
	add_child(explosion)
	$AudioStreamPlayer2D.play()
	$AnimatedSprite.hide()
	explosion.connect("particles_ended", self, "queue_free")
	$CollisionShape2D.set_deferred("disabled", true)
