extends CharacterBody2D



const ATTACK_DISTANCE = 20.0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
	# Add the g$"."ravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	# if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var verticalDir = Input.get_axis("MoveUp", "MoveDown")
	if verticalDir:
		velocity.y = verticalDir * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	velocity = velocity.normalized()  * SPEED
	
	if Input.is_action_pressed("Attack"):
		_attack()
	if Input.is_action_just_released("Attack"):
		$DamageSprite.visible = false
	
	move_and_slide()

func _attack():
	$DamageSprite.visible = true
	var dmgVec = get_local_mouse_position().normalized()*ATTACK_DISTANCE
	
	$DamageSprite.position = dmgVec
	$DamageSprite.rotation = dmgVec.angle()
	#$DamageSprite.rotate(dmgVec.))
	print_debug( get_local_mouse_position().normalized())
