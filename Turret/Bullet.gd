extends Area2D
var DIRECTION : Vector2
var SPEED = 1500.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	position+= DIRECTION*SPEED*delta
	#move_and_collide(DIRECTION)
	
	for body in get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			body.damage(10)
			queue_free()

	
