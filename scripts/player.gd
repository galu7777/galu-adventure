extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D =$jumpSound

const SPEED = 300.0
const JUMP_VELOCITY = -900.0
var alive = true

func _physics_process(delta: float) -> void:
	
	if !alive:
		return
	
	# Run Animation
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite.animation = "walk"
	elif velocity.x == 0:
		animated_sprite.animation = "idle"
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite.animation = "jump"

	# Handle jump.
	if Input.is_action_just_pressed("salto") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()
		

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("izquierda", "derecha")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if direction == 1.0:
		animated_sprite.flip_h = false
		
	if direction == -1.0:
		animated_sprite.flip_h = true

func die() -> void:
	animated_sprite.animation = "run"
	alive = false
