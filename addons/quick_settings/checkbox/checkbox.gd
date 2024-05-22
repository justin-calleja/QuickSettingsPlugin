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
@export var _setting_type: SettingType = SettingType.PROJECT

enum SettingType { EDITOR, PROJECT }
var editor_settings = EditorInterface.get_editor_settings()


func get_setting() -> Variant:
	if _setting_type == SettingType.EDITOR:
		return editor_settings.get(_setting_path)
	else:
		return ProjectSettings.get_setting(_setting_path)


func set_setting(val: bool):
	if _setting_type == SettingType.EDITOR:
		editor_settings.set(_setting_path, val)
	else:
		ProjectSettings.set_setting(_setting_path, val)


func _ready():
	link_button.text = _linkBtnText
	check_box.set_pressed_no_signal(get_setting())
	editor_settings.settings_changed.connect(_on_settings_changed)


func _on_link_button_pressed() -> void:
	check_box.button_pressed = not check_box.button_pressed


func _on_check_box_toggled(toggled_on: bool) -> void:
	set_setting(toggled_on)
	#print('Plugin<quick_settings>: $s %s' % ["enabled" if toggled_on else "disabled", _setting_path])

func _on_settings_changed() -> void:
	# print("in _on_settings_changed with get of: %s" % get_setting()
	check_box.set_pressed_no_signal(get_setting())
