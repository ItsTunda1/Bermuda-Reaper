extends Node2D




@export var delay_before_fade: float = 2.0   # Seconds to wait before fading
@export var fade_duration: float = 1.5       # Duration of fade out

var color_rect: ColorRect
var timer := 0.0
var fading := false

func _ready():
	color_rect = $ColorRect  # Adjust this path if needed
	await get_tree().create_timer(delay_before_fade).timeout
	fading = true

func _process(delta):
	if fading:
		timer += delta
		var alpha = 1.0 - (timer / fade_duration)
		alpha = clamp(alpha, 0.0, 1.0)
		var current_color = color_rect.color
		current_color.a = alpha
		color_rect.color = current_color

		if alpha <= 0.0:
			queue_free()  # Delete the node this script is attached to
