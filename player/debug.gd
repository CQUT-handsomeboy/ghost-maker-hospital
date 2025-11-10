extends PanelContainer

@onready var property_container = $MarginContainer/VBoxContainer


var property
var frames_per_seconds:String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	global.debug = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event) -> void:
	if event.is_action_pressed("debug"):
		visible = !visible

func _process(delta):
	pass

func add_property(title:String,value,order):
	var target
	target = property_container.find_child(title,true,false)
	if !target:
		property = Label.new()
		property_container.add_child(property)
		property.name = title
		property.text = property.name + ":" + str(value)
	elif visible:
		target.text = title + ":" + str(value)
		property_container.move_child(target,order)
		
