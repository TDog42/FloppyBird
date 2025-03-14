@tool
extends RichTextEffect
class_name RichTextJump

# Define the tag name.
var bbcode = "jump"

var time = 0.0

func _process_custom_fx(char_fx):
	# Get parameters, or use the provided default value if missing.
	var speed = char_fx.env.get("freq", 10.0)
	var span = char_fx.env.get("span", 10.0)

	var alpha = sin(char_fx.elapsed_time * speed + (char_fx.range.x / span)) *5 + 0.5
	print(alpha)
	char_fx.offset.y = alpha
	return true
