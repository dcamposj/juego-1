extends CharacterBody2D # Cambiado de Node2D para usar físicas reales

const SPEED = 50.0
const JUMP_VELOCITY = -250.0
var direction = 1

@export var speed = 60.0


# Gravedad del proyecto
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var ray_cast_wall: RayCast2D = $RayCastWall
@onready var ray_cast_ledge: RayCast2D = $RayCastLedge
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	# 1. Aplicar Gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# 2. Detección de Obstáculos y Precipicios
	# Si choca con pared O NO detecta suelo adelante, gira.
	if is_on_wall() or not ray_cast_ledge.is_colliding():
		direction *= -1
		_update_raycasts()

	# 3. Movimiento
	velocity.x = direction * speed
	
	# 4. Voltear Visuales
	sprite.flip_h = (direction == -1)

	move_and_slide()

	# 5. Muerte por caída (Safety net)
	if position.y > 132:
		die()

func _update_raycasts():
	# Invertimos la posición local de los RayCasts según la dirección
	ray_cast_wall.target_position.x = abs(ray_cast_wall.target_position.x) * direction
	ray_cast_ledge.position.x = abs(ray_cast_ledge.position.x) * direction

func die():
	queue_free()
