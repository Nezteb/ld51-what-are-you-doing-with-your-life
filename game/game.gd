extends Control

var start_time: int = 0

var seconds: int = 1
var minutes: int = 60 * seconds
var hours: int = 60 * minutes
var days: int = 24 * hours
var years: int = 365 * days

var age_in_10_seconds = (Root.age * years / 10)

var time_playing = 0

# Pulled from https://godotengine.org/qa/18559/how-to-add-commas-to-an-integer-or-float-in-gdscript
func comma_sep(number):
	var string = str(number)
	var mod = string.length() % 3
	var res = ""

	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]

	return res

func set_age(age):
	var textNode = get_node("Reality/AgeLabel")
	textNode.set_text(comma_sep(age))

# Called when the node enters the scene tree for the first time.
func _ready():
	start_time = int(Time.get_unix_time_from_system())
	set_age(age_in_10_seconds)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_time = int(Time.get_unix_time_from_system())
	var new_time_playing = current_time - start_time
	if(time_playing == new_time_playing):
		return
	
	print("tick: ", time_playing)
	time_playing = new_time_playing
	if(time_playing % 10 == 0):
		var ten_second_increments = time_playing / 10
		var new_age = age_in_10_seconds + ten_second_increments
		set_age(new_age)
		
		var gameTimeNode = get_node("Reality/GameTime")
		gameTimeNode.set_text(comma_sep(ten_second_increments))
		
		var percentageTime = float(ten_second_increments) / float(age_in_10_seconds) * float(100.0)
		var percentageTimeNode = get_node("Reality/PercentageTime")
		percentageTimeNode.set_text("%s%%" % str(percentageTime))
	pass
