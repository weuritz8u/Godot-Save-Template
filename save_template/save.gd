# script written by Shadowdara

extends Node2D

var save_path = "user://godot_save_template.save"

var saved_text = 0

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
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(saved_text)

	print("Data saved")

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		saved_text = file.get_var(saved_text)

		$"RichTextLabel".text = str(saved_text)

		print("Data Loaded")

	else:
		print("no data saved...")
		saved_text = 0
