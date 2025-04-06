# script written by Shadowdara

extends Node2D

# saving the save folder path in a variable
var save_path = "user://godot_save_template.save"

# variables
var saved_text = 0
var saved_number = 0

func _ready():
	$"RichTextLabel".text = str(saved_text)

func _process(_delta):
	pass

func _on_minus_pressed():
	saved_text -= 1
	$"RichTextLabel".text = str(saved_text)

func _on_load_pressed() -> void:
	load_data()

func _on_folder_pressed() -> void:
	# to open the save folder path
	var absolute_path = ProjectSettings.globalize_path(save_path)
	OS.shell_open(absolute_path.get_base_dir())

func _on_save_pressed() -> void:
	save()

func _on_credits_pressed() -> void:
	OS.shell_open("https://github.com/weuritz8u")

func _on_add_pressed():
	saved_text += 1
	$"RichTextLabel".text = str(saved_text)

func save():
	# save file access in a variable
	var file = FileAccess.open(save_path, FileAccess.WRITE)

	# the variables we want to save 
	file.store_var(saved_text)

	# if we want to save another variables with the name: saved_number
	file.store_var(saved_number)

	print("Data saved")

func load_data():
	# check if there is a save file
	if FileAccess.file_exists(save_path):

		# save the file access in variable
		var file = FileAccess.open(save_path, FileAccess.READ)

		# load the variable from the save file
		saved_text = file.get_var(saved_text)

		# e.g. for another variable
		saved_number = file.get_var(saved_number)

		# just update the text label
		$"RichTextLabel".text = str(saved_text)

		print("Data Loaded")

	else:
		print("no data saved...")
		saved_text = 0
