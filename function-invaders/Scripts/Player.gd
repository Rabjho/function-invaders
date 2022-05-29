extends KinematicBody2D


export var speed = 700 # How fast the player will move (pixels/sec).
export var acceleration = 4000
export var deceleration = 7000
var screen_size # Size of the game window.
var velocity = Vector2.ZERO
var direction

export(PackedScene) var bullet_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size
	rotation -= PI / 2 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = Vector2.ZERO #The player's movement vector.

	if (Input.is_action_pressed("move_down")):
		direction.y += 1

	if (Input.is_action_pressed("move_up")):
		direction.y -= 1

	if ((direction == Vector2.ZERO or direction.normalized() != velocity.normalized()) and velocity != Vector2.ZERO):
		velocity *= clamp((velocity.length() - deceleration * delta)/velocity.length(), 0, velocity.length())
	
	if (velocity.is_equal_approx(Vector2.ZERO)):
		velocity = Vector2.ZERO
	
	velocity += acceleration * direction * delta
	velocity = velocity.clamped(speed)
	position += velocity * delta
		
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if (Input.is_action_pressed("shoot_bullet") and $ShootCooldown.time_left == 0 and visible):
		$ShootCooldown.start()
		var bullet = bullet_scene.instance()
		bullet.position = position
		bullet.rotation = rotation
		owner.add_child(bullet)



func start():
	position = Vector2(screen_size.x * 9/10, screen_size.y / 2);
	show()
	$CollisionPolygon2D.disabled = false


func game_over():
	$CollisionPolygon2D.set_deferred("disabled", true)
	hide()
	

