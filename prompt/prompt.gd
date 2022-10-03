extends Control

var age: int = 0
signal too_old

func validate_age():
	var textNode = get_node("TextEdit")
	var text = textNode.get_text()
	var buttonNode = get_node("Button")
	
	var regex = RegEx.new()
	regex.compile("^[0-9]+$")
	
	# Reset text if user types any non-numeric characters
	if(!regex.search(text)):
		textNode.set_text("")
		buttonNode.set_text("I've been alive for...")

func read_age():
	var textNode = get_node("TextEdit")
	var text = textNode.get_text()
	
	if(text != ""):
		age = text.to_int()
		var buttonNode = get_node("Button")
		var button_text = "I've been alive for %d years" % age
		buttonNode.set_text(button_text)
	
func set_age(new_age):
	age = new_age
	
	var textNode = get_node("TextEdit")
	textNode.set_text(str(age))
	
	var buttonNode = get_node("Button")
	var button_text = "I've been alive for %d years" % age
	buttonNode.set_text(button_text)

func _on_text_edit_text_changed():
	validate_age()
	read_age()
	
	if(age > 99):
		set_age(99)
		emit_signal("too_old")

func _on_button_pressed():
	Root.age = age
	get_tree().change_scene_to_file("res://game/game.tscn")

func _on_prompt_too_old():
	var alert_title = "Please stop playing and spend time with your loved ones while you still can."
	var alert_message = "You are too close to death to play..."
	OS.alert(alert_title, alert_message)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
