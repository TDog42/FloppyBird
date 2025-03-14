extends Node2D

var pipe = preload("res://scenes/pipe.tscn")
@onready var floppy_bird: CharacterBody2D = $FloppyBird
@onready var background: ParallaxBackground = $Background
@onready var floor_variation: Node2D = $Floor/FloorVariation
@onready var floor: TileMapLayer = $Floor
@onready var space_button: AnimatedSprite2D = $SpaceButton
@onready var title: Node2D = $CenterContainer/Title
@onready var score: Node2D = $CenterContainer/ScoreScript/score



var screen_size = DisplayServer.window_get_size()
var timer: Timer = Timer.new()
var timeout: float = 4
var collision = false
var started = false
var tween: Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set player to 1/3 of the screen
	floppy_bird.position.x = screen_size.x / 3
	space_button.position.x = screen_size.x / 2
	space_button.play()
	score.hide()


func _pipe_collision():
	collision = true
	timer.stop()
	
	#restart scene in 3 seconds
	timer.set_wait_time(3)
	timer.timeout.connect(_restart)
	timer.start()

func _start_game():
	space_button.stop()
	space_button.hide()
	title.hide()
	score.show()
	
	started = true
	
	#set a timeout an call the function to create a new pipe
	timer.set_wait_time(timeout)
	timer.one_shot = false
	timer.timeout.connect(_createPipe)
	add_child(timer) 	
	timer.start()
	floppy_bird.pipe_collision.connect(_pipe_collision)
	floppy_bird.start_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !started:
		if Input.is_action_just_pressed("jump"):
			_start_game()
		
	if !collision:
		background.scroll_offset.x -= 2


func _createPipe():
	if !collision:
		var pipe_instance : Pipe = pipe.instantiate()	
		add_child(pipe_instance)
		pipe_instance.add_pipe_collision_signal(floppy_bird)
		
func _restart() -> void:
	get_tree().reload_current_scene()
