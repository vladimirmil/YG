extends Control


var Card = preload("res://Scenes/card.tscn")

signal slotPressed

@onready var cardContainer : Control = $Control
@onready var highlightColorRect : ColorRect = $HighlightColorRect
@onready var button : Button = $Button
@onready var backgroundColorRect : ColorRect = $ColorRect

enum OWNER {PLAYER = 0, OPPONENT}
enum TYPE {MONSTER = 0, SPELL_TRAP, EXTRA, GRAVEYARD, OUT_OF_PLAY, FIELD}

@export var _owner : OWNER
@export var _type : TYPE


var isOcuppied : bool = false
var data : Dictionary = {}


func _ready() -> void:
	button.pressed.connect(OnSlotPressed)
	highlightColorRect.visible = false
	match _type:
		TYPE.MONSTER:
			backgroundColorRect.color = Color(0.41, 0.27, 0.1)
		TYPE.SPELL_TRAP:
			backgroundColorRect.color = Color(0.14, 0.35, 0.2)
		TYPE.EXTRA:
			backgroundColorRect.color = Color(0.06, 0.34, 0.41)
		TYPE.GRAVEYARD:
			backgroundColorRect.color = Color(0.3, 0.3, 0.3)
		TYPE.OUT_OF_PLAY:
			backgroundColorRect.color = Color(0.54, 0.12, 0.17)
		TYPE.FIELD:
			backgroundColorRect.color = Color(0.71, 0.11, 0.84)


# _action = "Sp.Summon", "Summon", "Set" "Activate"
func AddCard(_data : Dictionary, _action : String) -> void: 
	data = _data.duplicate()
	var v : bool = false
	if _action != "Set":
		v = true
	
	var c = Card.instantiate()
	
	c.isShown = v
	cardContainer.add_child(c)
	c.position = Vector2(0.0,0.0)
	print(_action)
	c.SetData(data)


func RemoveCard() -> void: data.clear()


func GetType() -> int: return _type
func GetOccupied() -> bool: return isOcuppied
func IsHighlighted() -> bool: return highlightColorRect.visible

## pos=0 atk,     pos=1 def
## vis=0 visible, vis=1 not visible
#func PlaceCard(pos : int = 0, vis : int = 0) -> void:
	#pass



func Highlight() -> void: highlightColorRect.visible = true
func Unhighlight() -> void: highlightColorRect.visible = false



func OnSlotPressed() -> void:
	slotPressed.emit(self)#_owner, _type, isOcuppied)







