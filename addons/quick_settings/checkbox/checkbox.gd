@tool
class_name QSCheckbox
extends Node

enum SettingType { EDITOR, PROJECT }

@export var _linkBtnText: String:
	set(new_linkBtnText):
		_linkBtnText = new_linkBtnText
		if link_button: link_button.text = _linkBtnText
@export var _setting_path: String
@export var _setting_type: SettingType = SettingType.PROJECT

var _editor_settings = EditorInterface.get_editor_settings()

@onready var h_box_container = $HBoxContainer
@onready var check_box = $HBoxContainer/CheckBox
@onready var link_button = $HBoxContainer/MarginContainer/LinkButton


func get_setting() -> Variant:
	if _setting_type == SettingType.EDITOR and _editor_settings:
		return _editor_settings.get(_setting_path)
	else:
		return ProjectSettings.get_setting(_setting_path)


func set_setting(val: Variant):
	if _setting_type == SettingType.EDITOR:
		_editor_settings.set(_setting_path, val)
	else:
		ProjectSettings.set_setting(_setting_path, val)


func _ready():
	link_button.text = _linkBtnText
	check_box.set_pressed_no_signal(get_setting())
	_editor_settings.settings_changed.connect(_on_settings_changed)
	ProjectSettings.settings_changed.connect(_on_settings_changed)


func _on_link_button_pressed() -> void:
	check_box.button_pressed = not check_box.button_pressed


func _on_check_box_toggled(toggled_on: bool) -> void:
	set_setting(toggled_on)
	# print('Plugin<quick_settings>: %s %s' % ["enabled" if toggled_on else "disabled", _setting_path])

func _on_settings_changed() -> void:
	var _setting = get_setting()
	check_box.set_pressed_no_signal(false if _setting == null else _setting)
	# print("in _on_settings_changed with get of: %s" % _setting)
