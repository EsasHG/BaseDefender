extends CharacterBody2D

const ATTACK_DISTANCE = 30.0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var ATTACKING : bool = false
var damageEffect = preload("res://Player/AttackSprite.tscn")


func _physics_process(delta):
	
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
	
	if !ATTACKING and Input.is_action_pressed("Attack"):
		_attack()
		
	var dmgVec = get_local_mouse_position().normalized()*ATTACK_DISTANCE
	$Spear.rotation = dmgVec.angle()
	move_and_slide()

func _attack():

	ATTACKING = true
#	var dmgSprite = Sprite2D.new()
#	dmgSprite.texture =CanvasTexture.new()
#	dmgSprite.scale.x  = 40
#	dmgSprite.scale.y  = 30
	var dmgSprite = damageEffect.instantiate()
	
	add_child(dmgSprite)
#	get_tree().root.add_child(dmgSprite)
	dmgSprite.modulate = Color.TRANSPARENT
	dmgSprite.visible = true
	
	var dmgVec = get_local_mouse_position().normalized()*ATTACK_DISTANCE
	
	dmgSprite.position = dmgVec
	dmgSprite.rotation = dmgVec.angle()
	
	var spriteTween = get_tree().create_tween()
	spriteTween.set_ease(Tween.EASE_OUT)
	spriteTween.tween_property(dmgSprite,"modulate", Color.DARK_GRAY, 0.04)
	spriteTween.set_ease(Tween.EASE_IN)
	spriteTween.tween_property(dmgSprite, "modulate", Color.TRANSPARENT,0.2)
	spriteTween.tween_callback(func(): 
		ATTACKING = false	
		dmgSprite.queue_free()
		return
	)
	
	var spearTween = get_tree().create_tween()
	spearTween.set_ease(Tween.EASE_OUT)
	spearTween.tween_property($Spear,"position", dmgVec, 0.04)
	spearTween.set_ease(Tween.EASE_IN)
	spearTween.tween_property($Spear, "position", Vector2(0,0),0.2)
	
