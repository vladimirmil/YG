extends Button

signal leftClick
signal rightClick

func _ready():
	gui_input.connect(OnButtonPressed)
#_on_Button_gui_input
func OnButtonPressed(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				leftClick.emit()
			MOUSE_BUTTON_RIGHT:
				rightClick.emit()
