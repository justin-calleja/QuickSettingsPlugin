@tool
extends Control

@onready var h_box_container = $HBoxContainer
@onready var check_box = $HBoxContainer/CheckBox
@onready var link_button = $HBoxContainer/MarginContainer/LinkButton


@export var _linkBtnText: String:
	set(new_linkBtnText):
		_linkBtnText = new_linkBtnText
		link_button.text = _linkBtnText
@export var _setting_path: String
# TODO: use this:
@export var _setting_type: SettingType = SettingType.PROJECT

enum SettingType { EDITOR, PROJECT }
var settings = EditorInterface.get_editor_settings()

func _ready():
	link_button.text = _linkBtnText
	check_box.set_pressed_no_signal(settings.get(_setting_path))
	settings.settings_changed.connect(_on_settings_changed)


func _on_link_button_pressed() -> void:
	check_box.button_pressed = not check_box.button_pressed


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		#print('Plugin<toggle_external_editor>: enabled %s' % _setting_path)
		settings.set(_setting_path, true)
	else:
		#print('Plugin<toggle_external_editor>: disabled %s' % _setting_path)
		settings.set(_setting_path, false)


func _on_settings_changed() -> void:
	# print("in _on_settings_changed with get of: %s" % settings.get(_setting_path))
	check_box.set_pressed_no_signal(settings.get(_setting_path))
