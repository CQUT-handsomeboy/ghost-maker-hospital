extends Node3D

@onready var light :OmniLight3D = $flash
@onready var emitter: GPUParticles3D = $emitter

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_flash_timer_timeout() -> void:
	light.visible = false
	emitter.emitting = false
