extends RichTextLabel

@onready var floppy_bird: CharacterBody2D = $"../FloppyBird"
var score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_text(str(score))
	floppy_bird.pipe_passed.connect(_pipe_passed)

func _pipe_passed():
	#add 1 to score and update
	score += 1
	_update_text(str(score))

func _update_text(text: String):
	#parse_bbcode("[wave amp=75.0 freq=10.0 connected=0]")
	parse_bbcode("[center]")
	push_font_size(100)
	push_color("blue")
	push_outline_color("black")
	push_outline_size(16)

	add_text(text)
	pop()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	push_font_size(64)
