 extends RigidBody2D


export(float) var speed = 4000
export(PackedScene) var explosion_scene

var screenSize
# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport().size
	_move(Vector2(-100,position.y))

func _move(target):
	$Tween.interpolate_property(self, "position", position, target, (position - target).length() / speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()

