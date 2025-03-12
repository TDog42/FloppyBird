extends Node2D

var pipe = preload("res://scenes/pipe.tscn")
@onready var floppy_bird: CharacterBody2D = $FloppyBird
@onready var background: ParallaxBackground = $Background


var timer: Timer = Timer.new()
var timeout: float = 1.5
var collision = false
var tween: Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set a timeout an call the function to create a new pipe
	timer.set_wait_time(timeout)
	timer.one_shot = false
	timer.timeout.connect(_createPipe)
	add_child(timer) 	
	timer.start()
	floppy_bird.pipe_collision.connect(_pipe_collision)

func _pipe_collision():
	collision = true
	timer.stop()
	
	#restart scene in 3 seconds
	timer.set_wait_time(3)
	timer.timeout.connect(_restart)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !collision:
		background.scroll_offset.x -= 2


func _createPipe():
	if !collision:
		var pipeInstance : Pipe = pipe.instantiate()	
		add_child(pipeInstance)
		pipeInstance.add_pipe_collision_signal(floppy_bird)
		
func _restart() -> void:
	get_tree().reload_current_scene()
