@tool
class_name QSSetDropdownWithCheckbox
extends QSCheckbox

enum DropdownOption { FIRST, SECOND, THIRD, FOURTH, FIFTH, SIXTH, SEVENTH }

@export var _toggled_dropdown_opt = DropdownOption.FIRST
@export var _untoggled_dropdown_opt = DropdownOption.SECOND


func _on_check_box_toggled(toggled_on: bool) -> void:
	set_setting(_toggled_dropdown_opt if toggled_on else _untoggled_dropdown_opt)


func _on_settings_changed() -> void:
	var _setting = get_setting()
	check_box.set_pressed_no_signal(_setting == _toggled_dropdown_opt)
