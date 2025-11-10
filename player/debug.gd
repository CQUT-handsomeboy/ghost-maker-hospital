extends PanelContainer

@onready var property_container = $MarginContainer/VBoxContainer


var property
var frames_per_seconds:String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	add_debug_property("fps",frames_per_seconds)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event) -> void:
	if event.is_action_pressed("debug"):
		visible = !visible

func _process(delta):
	if visible:
		frames_per_seconds = "%.2f" % (1.0 / delta)
		property.text = property.name + ":" + frames_per_seconds

func add_debug_property(title:String,value):
	property = Label.new()
	property_container.add_child(property)
	property.name = title
	property.text = property.name + ":" + value
