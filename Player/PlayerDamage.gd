extends Area2D


var enemy = preload("res://Enemy/EnemyScript.cs")

var collided = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if body.is_in_group("Enemy") and not collided.has(body.get_instance_id()):
			collided.append(body.get_instance_id())
			body.damage(1)
			print("Hit Enemy")
