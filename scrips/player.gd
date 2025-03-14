extends CharacterBody2D

signal pipe_collision
signal pipe_passed

const SPEED = 300.0
const JUMP_VELOCITY = -300.0
var tween: Tween
var started = false

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var explosion: GPUParticles2D = $GPUParticles2D


func _ready() -> void:
	self.pipe_collision.connect(_pipe_collision)

func _pipe_collision():
	#explode
	explosion.emitting = true
	animator.hide()
	
func start_game():
	started = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and started:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if tween != null:
			tween.kill()
		tween = get_tree().create_tween()
		tween.tween_property(self, "rotation_degrees", -45, 3.0)
		
		velocity.y = JUMP_VELOCITY
		
	animator.play("default")
	
	#going down
	if(velocity.y > 50 and rotation <= 0):
		if tween != null:
			tween.kill()
		tween = get_tree().create_tween()
		tween.tween_property(self, "rotation_degrees", rotation_degrees + 75, 3.0)
		
		animator.stop()
	
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.collision_layer == 2 : 
		#pipe collision
		emit_signal("pipe_collision")
	elif area.collision_layer == 4:
		#pipe passed
		emit_signal("pipe_passed")
	


func _on_gpu_particles_2d_finished() -> void:
	hide()
