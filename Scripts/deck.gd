extends Control


signal cardDrawn


var Card = preload("res://Scenes/card.tscn")


@onready var cardsControl : Control = $Cards
@onready var numberOfCardsLabel : Label = $NumberOfCards

var tempDataInput : Array = [
	{'id': 85639257, 'name': 'Aqua Madoor', 'type': 'normal', 'desc': 'A wizard of the waters that conjures a liquid wall to crush any enemies that oppose him.', 'atk': 1200, 'def': 2000, 'level': 4, 'race': 'Spellcaster', 'attribute': 'WATER'},
	{'id': 53153481, 'name': 'Armaill', 'type': 'normal', 'desc': 'A strange warrior who manipulates three deadly blades with both hands and his tail.', 'atk': 700, 'def': 1300, 'level': 3, 'race': 'Warrior', 'attribute': 'EARTH'},
	{'id': 9076207, 'name': 'Armed Ninja', 'type': 'effect', 'desc': 'FLIP: Target 1 Spell Card on the field; destroy that target. (If the target is Set, reveal it, and destroy it if it is a Spell Card. Otherwise, return it to its original position.)', 'atk': 300, 'def': 300, 'level': 1, 'race': 'Warrior', 'attribute': 'EARTH'},
	{'id': 17535588, 'name': 'Armored Starfish', 'type': 'normal', 'desc': 'A bluish starfish with a solid hide capable of fending off attacks.', 'atk': 850, 'def': 1400, 'level': 4, 'race': 'Aqua', 'attribute': 'WATER'},
	{'id': 89091579, 'name': 'Basic Insect', 'type': 'normal', 'desc': "Usually found traveling in swarms, this creature's ideal environment is the forest.", 'atk': 500, 'def': 700, 'level': 2, 'race': 'Insect', 'attribute': 'EARTH'},
	{'id': 46009906, 'name': 'Beast Fangs', 'type': 'spell', 'desc': 'A Beast-Type monster equipped with this card increases its ATK and DEF by 300 points.', 'atk': 0, 'def': 0, 'level': 0, 'race': '', 'attribute': ''},
	{'id': 32452818, 'name': 'Beaver Warrior', 'type': 'normal', 'desc': 'What this creature lacks in size it makes up for in defense when battling in the prairie.', 'atk': 1200, 'def': 1500, 'level': 4, 'race': 'Beast-Warrior', 'attribute': 'EARTH'},
	{'id': 89631139, 'name': 'Blue-Eyes White Dragon', 'type': 'normal', 'desc': 'This legendary dragon is a powerful engine of destruction. Virtually invincible, very few have faced this awesome creature and lived to tell the tale.', 'atk': 3000, 'def': 2500, 'level': 8, 'race': 'Dragon', 'attribute': 'LIGHT'},
	{'id': 91595718, 'name': 'Book of Secret Arts', 'type': 'spell', 'desc': 'A Spellcaster-Type monster equipped with this card increases its ATK and DEF by 300 points.', 'atk': 0, 'def': 0, 'level': 0, 'race': '', 'attribute': ''},
	{'id': 91152256, 'name': 'Celtic Guardian', 'type': 'normal', 'desc': 'An elf who learned to wield a sword, he baffles enemies with lightning-swift attacks.', 'atk': 1400, 'def': 1200, 'level': 4, 'race': 'Warrior', 'attribute': 'EARTH'},
	{'id': 37421579, 'name': 'Charubin the Fire Knight', 'type': 'fusion', 'desc': '"Monster Egg" + "Hinotama Soul"', 'atk': 1100, 'def': 800, 'level': 3, 'race': 'Pyro', 'attribute': 'FIRE'},
	{'id': 28279543, 'name': 'Curse of Dragon', 'type': 'normal', 'desc': 'A wicked dragon that taps into dark forces to execute a powerful attack.', 'atk': 2000, 'def': 1500, 'level': 5, 'race': 'Dragon', 'attribute': 'DARK'},
	{'id': 4614116, 'name': 'Dark Energy', 'type': 'spell', 'desc': 'Increase the ATK and DEF of a Fiend-Type monster equipped with this card by 300 points.', 'atk': 0, 'def': 0, 'level': 0, 'race': '', 'attribute': ''},
	{'id': 9159938, 'name': 'Dark Gray', 'type': 'normal', 'desc': 'Entirely gray, this beast has rarely been seen by mortal eyes.', 'atk': 800, 'def': 900, 'level': 3, 'race': 'Beast', 'attribute': 'EARTH'},
	{'id': 53129443, 'name': 'Dark Hole', 'type': 'spell', 'desc': 'Destroy all monsters on the field.', 'atk': 0, 'def': 0, 'level': 0, 'race': '', 'attribute': ''},
	{'id': 53375573, 'name': 'Dark King of the Abyss', 'type': 'normal', 'desc': "It's said that this King of the Netherworld once had the power to rule over the dark.", 'atk': 1200, 'def': 800, 'level': 3, 'race': 'Fiend', 'attribute': 'DARK'},
	{'id': 36996508, 'name': 'Dark Magician', 'type': 'normal', 'desc': "''The ultimate wizard in terms of attack and defense.''", 'atk': 2500, 'def': 2100, 'level': 7, 'race': 'Spellcaster', 'attribute': 'DARK'},
	{'id': 17881964, 'name': 'Darkfire Dragon', 'type': 'fusion', 'desc': '"Firegrass" + "Petit Dragon"', 'atk': 1500, 'def': 1250, 'level': 4, 'race': 'Dragon', 'attribute': 'DARK'},
	{'id': 43500484, 'name': 'Darkworld Thorns', 'type': 'normal', 'desc': 'A thorny plant found in the darklands that wraps itself around any unwary traveler.', 'atk': 1200, 'def': 900, 'level': 3, 'race': 'Plant', 'attribute': 'EARTH'},
	{'id': 40826495, 'name': 'Dissolverock', 'type': 'normal', 'desc': 'A monster born in the lava pits, it generates intense heat that can melt away its enemies.', 'atk': 900, 'def': 1000, 'level': 3, 'race': 'Rock', 'attribute': 'EARTH'},
	{'id': 50045299, 'name': 'Dragon Capture Jar', 'type': 'trap', 'desc': 'Change all face-up Dragon-Type monsters on the field to Defense Position, also they cannot change their battle positions.', 'atk': 0, 'def': 0, 'level': 0, 'race': '', 'attribute': ''},
	{'id': 1435851, 'name': 'Dragon Treasure', 'type': 'spell', 'desc': 'A Dragon-Type monster equipped with this card increases its ATK and DEF by 300 points.', 'atk': 0, 'def': 0, 'level': 0, 'race': '', 'attribute': ''},
	{'id': 70681994, 'name': 'Dragoness the Wicked Knight', 'type': 'fusion', 'desc': '"Armaill" + "One-Eyed Shield Dragon"', 'atk': 1200, 'def': 900, 'level': 3, 'race': 'Warrior', 'attribute': 'WIND'},
	{'id': 16353197, 'name': 'Drooling Lizard', 'type': 'normal', 'desc': 'A blood-sucking snake in human form that attacks any living being that passes nearby.', 'atk': 900, 'def': 800, 'level': 3, 'race': 'Reptile', 'attribute': 'EARTH'},
	{'id': 37820550, 'name': 'Electro-Whip', 'type': 'spell', 'desc': 'Increase the ATK and DEF of a Thunder-Type monster equipped with this card by 300 points.', 'atk': 0, 'def': 0, 'level': 0, 'race': '', 'attribute': ''},
	{'id': 75376965, 'name': 'Enchanting Mermaid', 'type': 'normal', 'desc': 'A beautiful mermaid that lures voyagers to a watery grave.', 'atk': 1200, 'def': 900, 'level': 3, 'race': 'Fish', 'attribute': 'WATER'},
	{'id': 95952802, 'name': 'Flower Wolf', 'type': 'fusion', 'desc': '"Silver Fang" + "Darkworld Thorns"', 'atk': 1800, 'def': 1400, 'level': 5, 'race': 'Beast', 'attribute': 'EARTH'},
	{'id': 46130346, 'name': 'Hinotama', 'type': 'spell', 'desc': 'Inflict 500 damage to your opponent.', 'atk': 0, 'def': 0, 'level': 0, 'race': '', 'attribute': ''},
	{'id': 96851799, 'name': 'Hinotama Soul', 'type': 'normal', 'desc': 'An intensely hot flame creature that rams anything standing in its way.', 'atk': 600, 'def': 500, 'level': 2, 'race': 'Pyro', 'attribute': 'FIRE'},
	{'id': 76184692, 'name': 'Hitotsu-Me Giant', 'type': 'normal', 'desc': 'A one-eyed behemoth with thick, powerful arms made for delivering punishing blows.', 'atk': 1200, 'def': 1000, 'level': 4, 'race': 'Beast-Warrior', 'attribute': 'EARTH'},
	{'id': 15401633, 'name': 'Kagemusha of the Blue Flame', 'type': 'normal', 'desc': "Serving as a double for the Ruler of the Blue Flame, he's a master swordsman that wields a fine blade.", 'atk': 800, 'def': 400, 'level': 2, 'race': 'Warrior', 'attribute': 'EARTH'},
	{'id': 54541900, 'name': 'Karbonala Warrior', 'type': 'fusion', 'desc': '"M-Warrior #1" + "M-Warrior #2"', 'atk': 1500, 'def': 1200, 'level': 4, 'race': 'Warrior', 'attribute': 'EARTH'},
	{'id': 84686841, 'name': 'King Fog', 'type': 'normal', 'desc': 'A fiend that dwells in a blinding curtain of smoke.', 'atk': 1000, 'def': 900, 'level': 3, 'race': 'Fiend', 'attribute': 'DARK'},
	{'id': 56283725, 'name': 'Kumootoko', 'type': 'normal', 'desc': 'A massive, intelligent spider that traps enemies with webbing.', 'atk': 700, 'def': 1400, 'level': 3, 'race': 'Insect', 'attribute': 'EARTH'},
	{'id': 85705804, 'name': 'Kurama', 'type': 'normal', 'desc': 'A vicious bird that attacks from the skies with its whip-like tail.', 'atk': 800, 'def': 800, 'level': 3, 'race': 'Winged Beast', 'attribute': 'WIND'},
	{'id': 94675535, 'name': 'Larvas', 'type': 'normal', 'desc': 'A fast-moving, bird-like creature that strangles opposing monsters with its long, thin arms.', 'atk': 800, 'def': 1000, 'level': 3, 'race': 'Beast', 'attribute': 'EARTH'},
	{'id': 77007920, 'name': 'Laser Cannon Armor', 'type': 'spell', 'desc': 'Equip only to an Insect monster. It gains 300 ATK/DEF.', 'atk': 0, 'def': 0, 'level': 0, 'race': '', 'attribute': ''},
	{'id': 7902349, 'name': 'Left Arm of the Forbidden One', 'type': 'normal', 'desc': 'A forbidden left arm sealed by magic. Whosoever breaks this seal will know infinite power.', 'atk': 200, 'def': 300, 'level': 1, 'race': 'Spellcaster', 'attribute': 'DARK'},
	{'id': 44519536, 'name': 'Left Leg of the Forbidden One', 'type': 'normal', 'desc': 'A forbidden left leg sealed by magic. Whosoever breaks this seal will know infinite power.', 'atk': 200, 'def': 300, 'level': 1, 'race': 'Spellcaster', 'attribute': 'DARK'},
	{'id': 61854111, 'name': 'Legendary Sword', 'type': 'spell', 'desc': 'Equip only to a Warrior monster. It gains 300 ATK/DEF.', 'atk': 0, 'def': 0, 'level': 0, 'race': '', 'attribute': ''}
]

var initialSpawn : Vector2 = Vector2(5,5)
var cardSpawnOffset : Vector2 = Vector2(0.08, 0.5)
var data : Array = []


func _ready():
	SetData(tempDataInput)
	
	#RemoveCard(2)


func SetData(a : Array) -> void:
	data = a.duplicate()
	data.shuffle()
	numberOfCardsLabel.text = str(data.size())
	for i in range(0, tempDataInput.size(), 1):
		var c = Card.instantiate()
		cardsControl.add_child(c)
		c.position = Vector2(i*cardSpawnOffset.x+initialSpawn.x, -i*cardSpawnOffset.y+initialSpawn.y)
		c.SetData(data[i])
		c.pressed.connect(OnCardPressed)



func DrawCard(amount : int = 1) -> void:
	if GetSize() + 1 >= amount:
		for i in range(0, amount, 1):
			var c : Dictionary = RemoveCard().duplicate()
			emit_signal("cardDrawn", c)
	else:
		print("Not enough cards in a deck")


func DiscardToGraveyard() -> void: pass
func DiscardFromPlay() -> void: pass
func RevealCard() -> void: pass
func HideCard() -> void: pass
func Shuffle() -> void: pass
func AddCard() -> void: pass

# Removes a card from the top
func RemoveCard(i : int = 1) -> Dictionary:
	#print(data.size())
	#print(GetSize())
	var d : Dictionary = data[GetSize() + 1 - i]
	if GetSize() + 1 > 0:
		data.remove_at(GetSize() + 1 - i)
		cardsControl.get_child(GetSize() + 2 - i).queue_free()
	numberOfCardsLabel.text = str(GetSize()+1)
	print("Removed from deck: ", d["name"])
	return d


func GetSize() -> int: return data.size()-1#cardsControl.get_child_count() - 1



func OnCardPressed() -> void:
	DrawCard()
