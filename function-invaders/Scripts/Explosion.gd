extends Particles2D


signal particles_ended

# Called when the node enters the scene tree for the first time.
func _ready():
	emitting = true # Replace with function body.
	one_shot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	if (not emitting):
		emit_signal("particles_ended")
		queue_free()
