extends CharacterBody2D

signal killed()

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var max_health = 100
@onready var health = max_health


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func kill():
	visible=false
	#MAKE PLAYER DISSAPEAR OR DEATH ANIMATION WHEN KILLED

func damage(amount):
	_set_health(health-amount)

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health _updated", health)
	if health == 0:
		kill()
		emit_signal("killed")
