@tool
class_name QSSetDropdownWithCheckbox
extends QSCheckbox

@export var _toggled_dropdown_opt = DropdownOption.FIRST

enum DropdownOption { FIRST, SECOND, THIRD, FOURTH, FIFTH, SIXTH, SEVENTH }


func _on_check_box_toggled(toggled_on: bool) -> void:
		if toggled_on:
				set_setting(_toggled_dropdown_opt)
