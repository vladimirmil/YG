extends Control

signal pressed


@onready var popupActionPanel : Panel = $PopupActionPanel
@onready var popupActionLabel : Label = $PopupActionPanel/PopupLabel
@onready var backside : TextureRect = $Back
# SHARED
@onready var frame : TextureRect = $Frame
@onready var nameLabel : Label = $Frame/Name
@onready var artSprite : TextureRect = $Frame/Art
@onready var attributeSprite : TextureRect = $Frame/Attribute
# MONSTER
@onready var monsterControl : Control = $Frame/Monster
@onready var levelSprite : Sprite2D = $Frame/Monster/Level
@onready var descriptionMLabel : RichTextLabel = $Frame/Monster/Description
@onready var raceLabel : Label = $Frame/Monster/Race
@onready var atkLabel : Label = $Frame/Monster/Atk
@onready var defLabel : Label = $Frame/Monster/Def
# SPELL/TRAP
@onready var SpellTrapControl : Control = $Frame/SpellTrap
@onready var descriptionSTLabel : RichTextLabel = $Frame/SpellTrap/Description
@onready var spellTrapLabel : Label = $Frame/SpellTrap/Type



var typeDir : String = "res://Images/Frame/"
var artworkDir : String = "res://Images/Artwork/"
var attributeDir : String = "res://Images/Attribute/"
var data : Dictionary = {
	"id"        : "",
	"name"      : "",
	"type"      : "",
	"desc"      : "",
	"atk"       : 0,
	"def"       : 0,
	"level"     : 8,
	"attribute" : "",
	"race"      : "",
	"art"       : ""
}

var isShown : bool = false
#var isInDeck : bool = true
var isInHand : bool = false

var canActivate : bool = false
var canPlace : bool = false
var canSpecialSummon : bool = false
var canSummon : bool = false
#var availableActions : Array = [canSpecialSummon, canSummon canActivate, canPlace, , ]
var monsterActionStringArr : Array  = ["Sp.Summon", "Summon", "Set"]
var spellTrapActionStringArr : Array  = ["Activate", "Set"]
var actionArr : Array = []
var actionSelected : int = 0

func _ready():
	#SetData(
	#	{'id': 50045299, 'name': 'Dragon Capture Jar', 'type': 'trap', 'desc': 'Change all face-up Dragon-Type monsters on the field to Defense Position, also they cannot change their battle positions.', 'atk': 0, 'def': 0, 'level': 0, 'race': '', 'attribute': ''}
	#)
	$Button.leftClick.connect(OnLeftClickPressed)
	$Button.rightClick.connect(OnRightClick)
	$Button.mouse_entered.connect(OnMouseEntered)
	$Button.mouse_exited.connect(OnMouseExited)
	frame.visible = isShown
	popupActionPanel.visible = false



func SetData(_data : Dictionary) -> void:
	var artwork : Object = null
	var attribute : Object = null
	var type : Object = null
	var maxNameCharacterLength : int = 23
	
	# SET DATA
	data = _data.duplicate()
	
	if data["type"] == "spell" or data["type"] == "trap":
		monsterControl.visible = false
		SpellTrapControl.visible = true
		descriptionSTLabel.text = data["desc"]
		nameLabel.add_theme_color_override("font_color", Color(1.0,1.0,1.0,1.0))
		actionArr = spellTrapActionStringArr.duplicate()
		
	
	# SET TYPE SPECIFIC DATA
	if data["type"] == "spell":
		data["attribute"] = "SPELL"
		spellTrapLabel.text = "[ Spell Card ]"
	elif data["type"] == "trap":
		data["attribute"] = "TRAP"
		spellTrapLabel.text = "[ Trap Card ]"
	else:
		monsterControl.visible = true
		SpellTrapControl.visible = false
		if data["type"] == "effect":
			raceLabel.text = "[" + data["race"] + "/Effect]"
		else:
			raceLabel.text = "[" + data["race"] + "]"
		atkLabel.text = "ATK/" + str(data["atk"])
		defLabel.text = "DEF/" + str(data["def"])
		levelSprite.frame = levelSprite.vframes - data["level"]
		descriptionMLabel.text = data["desc"]
		actionArr = monsterActionStringArr.duplicate()
		
	# LOAD IMAGES
	artwork = load(artworkDir + str(data["id"]) + ".jpg")
	attribute = load(attributeDir + data["attribute"] + ".png")
	type = load(typeDir + data["type"] + ".png")
	
	# SET SHARED DATA
	artSprite.texture = artwork
	attributeSprite.texture = attribute
	frame.texture = type
	nameLabel.text = data["name"]
	
	if nameLabel.get_total_character_count() > maxNameCharacterLength:
		nameLabel.add_theme_font_size_override("font_size", 8)
		#nameLabel.add_theme_constant_override("theme_override_fonts/font/base_font/spacing_glyph",-2)





func GetLevel() -> int: return data["level"] 

func GetAttribute() -> String: return data["attribute"] 

func GetType() -> String: return data["type"] 

func GetAtk() -> int: return data["atk"] 

func GetDef() -> int: return data["def"] 

func GetCanActivate() -> bool: return canActivate

func GetCanPlace() -> bool: return canPlace

func SelectTargetForAnAttack() -> void: pass
func Activate() -> void: pass
func ReturnToDeck() -> void: pass
func ReturnToHand() -> void: pass
func DiscardToGraveyard() -> void: pass
func DiscardFromPlay() -> void: pass
func SpecialSummon() -> void: pass
func Place() -> void: pass



func OnLeftClickPressed() -> void:
	#print("left mouse")
	pressed.emit(data, actionArr[actionSelected])
	#emit_signal("pressed")


func OnRightClick() -> void:
	if actionSelected + 1 >= actionArr.size():
		actionSelected = 0
	else:
		actionSelected += 1
	popupActionLabel.text = actionArr[actionSelected]
	
	#print("right mouse")


func OnMouseEntered() -> void:
	if isInHand:
		z_index = 1
		position.y = -20
		#for i in availableActions:
		#	if i:
		actionSelected = 0
		popupActionLabel.text = actionArr[actionSelected]
		popupActionPanel.visible = true
	#print("entered")

func OnMouseExited() -> void:
	if isInHand:
		z_index = 0
		position.y = 0
		popupActionPanel.visible = false
	#print("exited")





