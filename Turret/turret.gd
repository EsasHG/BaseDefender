extends StaticBody2D


var Bullet = preload("res://Turret/Bullet.tscn")

const RANGE = 1000.0
const FIRE_RATE = 0.3
var attacking = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var all_enemies = get_tree().get_nodes_in_group("Enemy")
	
	var target = null
	
	var nearestDist = RANGE*RANGE
	for enemy in all_enemies:
		var distance2 = position.distance_squared_to(enemy.position)
		if distance2 < nearestDist:
			nearestDist = distance2
			target = enemy
	if target:
		var dmgVec = target.global_position - global_position
		dmgVec = dmgVec.normalized()
		$Barrel.rotation = lerp($Barrel.rotation, dmgVec.angle(), 0.1)
		if not attacking:
			attacking = true
			
			var b = Bullet.instantiate()
			b.global_position = global_position
			get_tree().root.add_child(b)
			b.DIRECTION = dmgVec
			
			get_tree().create_timer(FIRE_RATE, false, true).timeout.connect(func(): attacking = false)

		
	#$Barrel.position = dmgVec
#	$Barrel.rotation = dmgVec.angle()
	
	
		
