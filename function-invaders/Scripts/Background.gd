extends ParallaxBackground


export(float) var speed = 500
export(Vector2) var direction = Vector2(1,0)


func _process(delta):
	scroll_offset += direction.normalized() * speed * delta
	
	
