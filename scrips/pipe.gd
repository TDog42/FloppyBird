extends CharacterBody2D
class_name Pipe

var tween: Tween

var pipe_top = []
var pipe_bottom = []
var keep_moving = true

var screen_size = DisplayServer.window_get_size()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var start_y_position = randi_range(-150, 150)
	var tile_offset = randi_range(0,3)
	
	#position pipe outside screen
	position.x =  screen_size.x+100
	
	#move pipe up or down 
	self.position.y +=  start_y_position
		
	self.velocity.x = -100
	
	#load random pipe TileSet
	for child in $TileMaps/Top.get_children():
		pipe_top.append(child)
		
	for child in $TileMaps/Bottom.get_children():
		pipe_bottom.append(child)	
		
	var i = randi_range(0, pipe_top.size()-1)
	
	pipe_top[i].show()
	pipe_bottom[i].show()
 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if keep_moving:
		move_and_slide() 
	
	#delete pipe when out of sceen area
	if position.x < -50:
		queue_free()
		
	

func _pipe_collision():
	self.velocity.x = 0
	move_and_slide()
	keep_moving = false

func add_pipe_collision_signal(player):
	player.pipe_collision.connect(_pipe_collision)
	
