extends OptionButton

## NOTE: expects items to be "digits"x"digits" e.g. 1024x546

const PREFIX = "Viewport size: "

var _item_texts = []
var _prefixed_item_texts = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(item_count):
		var item_text = get_item_text(i)
		_item_texts.append(item_text)
		
		var prefixed_item_text = "%s%s" % [PREFIX, item_text]
		_prefixed_item_texts.append(prefixed_item_text)
		
		set_item_text(i, prefixed_item_text)

