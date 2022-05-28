extends Area2D


export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

export(PackedScene) var bullet_scene
export(PackedScene) var explosion_scene
signal player_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size
	rotation -= PI / 2 
	
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

func _input(_event):
	if (Input.is_action_just_pressed("shoot_bullet") and $ShootCooldown.time_left == 0 and visible):
		$ShootCooldown.start()
		var bullet = bullet_scene.instance()
		bullet.position = position
		bullet.rotation = rotation
		owner.add_child(bullet)



func start():
	position = Vector2(screen_size.x * 9/10, screen_size.y / 2);
	show()
	get_tree().call_group("particles", "hide")

	$CollisionPolygon2D.disabled = false


func _on_Player_body_entered(body):
	if ("asteroids" in body.get_groups()):
		emit_signal("player_hit")
		body._is_hit()
		var explosion = explosion_scene.instance()
		add_child(explosion)
		explosion.global_position = body.position

func game_over():
	$CollisionPolygon2D.set_deferred("disabled", true)
	hide()
	

