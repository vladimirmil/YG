extends Control


var Card = preload("res://Scenes/card.tscn")


@onready var deck : Control = $Deck
@onready var hand : Control = $Hand
@onready var opponentField : GridContainer = $Field/GridContainer
@onready var playerField : GridContainer = $Field/GridContainer2


enum TURN_PHASE { START, DRAW, STANDBY, MAIN_1, BATTLE, MAIN_2, END }
var phase : int = TURN_PHASE.START
var offset : int = 125
var timerFlag : bool = false
var cardPressedData : Dictionary = {}
var cardAction : String = ""



func _ready():
	deck.cardDrawn.connect(OnCardDrawn)
	for i in range(0, playerField.get_child_count(), 1):
		playerField.get_child(i).slotPressed.connect(OnSlotPressed)
	for i in range(0, opponentField.get_child_count(), 1):
		opponentField.get_child(i).slotPressed.connect(OnSlotPressed)


func _process(delta):
	$Label.text = str(cardPressedData)
	#print(cardPressedData)
	match phase:
		TURN_PHASE.START:
			#pass
			#phase = TURN_PHASE.DRAW
			if !timerFlag:
				$Timer.start(1)
				timerFlag = true
			#delay(1000)
		TURN_PHASE.DRAW:
			deck.DrawCard(1)
			phase = TURN_PHASE.STANDBY
		TURN_PHASE.STANDBY:
			pass
		TURN_PHASE.MAIN_1:
			pass
		TURN_PHASE.BATTLE:
			pass
		TURN_PHASE.MAIN_2:
			pass
		TURN_PHASE.END:
			pass
		






func OnCardDrawn(_d : Dictionary) -> void:
	var sideOffset : int = 450
	var maxHandWidth : int = 1290
	var cardSize : int = 123
	var d : Dictionary = _d.duplicate()
	var c = Card.instantiate()
	var n : int = 0#hand.get_child_count()#+1
	
	# Add a card to the hand
	c.isShown = true
	c.isInHand = true
	hand.add_child(c)
	n = hand.get_child_count()
	c.position = Vector2((n-1)*offset,0)
	c.SetData(d)
	c.pressed.connect(OnCardPressed)
	print("Added to hand: ", d["name"])
	
	# Calculate hand size
	hand.size.x = n * cardSize + (n-1) * (offset - cardSize)
	
	# If hand size is too large, reduce it's side and calculate new size until hand size less than maximum
	while hand.size.x >= maxHandWidth:
		offset -= 1
		for i in range(0, hand.get_child_count(), 1):
			hand.get_child(i).position.x = i*offset
		hand.size.x = n * cardSize + (n-1) * (offset - cardSize)
	# Center the hand
	hand.position.x = int(maxHandWidth / 2) - int(hand.size.x / 2) + sideOffset


func OnSlotPressed(o : Object) -> void:#o : int, t : int, isOcuppied : bool) -> void:
	#print(cardPressedData)
	if !cardPressedData.is_empty() and o.IsHighlighted():
		o.AddCard(cardPressedData, cardAction)
		cardPressedData.clear()
		cardAction = ""
		for i in playerField.get_children():
			i.Unhighlight()
	#if 
	#print(o, " ", t, " ", isOcuppied)



func _on_timer_timeout():
	if hand.get_child_count() < 5:
		deck.DrawCard()
		$Timer.start(0.2)
	else:
		phase = TURN_PHASE.DRAW


func OnCardPressed(_data : Dictionary, action : String) -> void:
	cardPressedData = _data.duplicate()
	cardAction = action
	var cardType : int = 0
	if cardPressedData["type"] == "spell" or cardPressedData["type"] == "trap":
		cardType = 1
	for i in playerField.get_children():
		if i.GetType() == cardType and !i.GetOccupied():
			i.Highlight()
		else:
			i.Unhighlight()
	#print(cardPressedData)
	
	#print(_data, " ", action)





