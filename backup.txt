extends Node2D

const SPEED = 30.0
var direction = 1  

# gravity and jumping
const GRAVITY = 500.0
const JUMP_VELOCITY = -200.0
var velocity := Vector2.ZERO
var ground_y: float = 0.0

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft

func _ready() -> void:
	# ensure randomness isn't the same every run
	randomize()
	# remember where the slime is standing so it can land back there
	ground_y = position.y

func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
	elif ray_cast_left.is_colliding():
		direction = 1
	
	# horizontal movement is independent of jump
	position.x += direction * SPEED * delta
	$AnimatedSprite2D.flip_h = (direction == -1)
	
	# apply gravity
	velocity.y += GRAVITY * delta
	position.y += velocity.y * delta
	
	# landed? clamp to starting height
	if position.y >= ground_y:
		position.y = ground_y
		velocity.y = 0
		# random jump chance when on floor
		if randi() % 100 < 2: # ~2% chance each frame
			velocity.y = JUMP_VELOCITY
