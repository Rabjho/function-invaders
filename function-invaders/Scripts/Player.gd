extends Area2D

export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size
	rotation -= PI / 2 
	
func _move(target):
	$Tween.interpolate_property(self, "position", position, target, 3, Tween.TRANS_CUBIC, Tween.EASE_OUT_IN)
	$Tween.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO #The player's movement vector.

	if (Input.is_action_pressed("move_down")):
		velocity.y += 1

	if (Input.is_action_pressed("move_up")):
		velocity.y -= 1

	if (velocity != Vector2.ZERO):
		velocity = velocity.normalized() * speed
		
		position += velocity * delta
		
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func start():
	position = Vector2(screen_size.x * 9/10, screen_size.y / 2);
	show()
	$CollisionPolygon2D.disabled = false

func _on_Player_body_entered(body):
	emit_signal("hit")

func _died():
	$CollisionPolygon2D.set_deferred("disabled", true)
	hide()
