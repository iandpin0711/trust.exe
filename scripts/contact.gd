extends Control

# References
@onready var contact_list = $HBoxContainer/ItemList
@onready var lbl_name = $HBoxContainer/ProfilePanel/VBoxContainer/NameLabel
@onready var lbl_situation = $HBoxContainer/ProfilePanel/VBoxContainer/SituationLabel
@onready var lbl_description = $HBoxContainer/ProfilePanel/VBoxContainer/DescriptionLabel
@onready var lbl_vulnerability = $HBoxContainer/ProfilePanel/VBoxContainer/VulnerabilityLabel
@onready var lbl_difficulty = $HBoxContainer/ProfilePanel/VBoxContainer/DifficultyLabel
@onready var lbl_hint = $HBoxContainer/ProfilePanel/VBoxContainer/HintLabel
@onready var btn_call = $HBoxContainer/ProfilePanel/VBoxContainer/CallButton

# Contact profile array
var profiles = [
	{
		"name": "Matilde",
		"age": "74 years",
		"situation": "Situation: Microsoft Technical Support",
		"description": "Description: Retired and devoted grandmother. Her computer is her only bridge to her family living far away. She doesn't understand technology, but she has an almost sacred respect for digital 'authorities'.",
		"vulnerability": "Vulnerability: Fear of emotional loss. She fears losing her grandchildren's photos more than the money itself.",
		"difficulty": "Difficulty Level: 1/5",
		"hint": "Hint: She is extremely polite. If you use a professional and calm tone, she will trust blindly."
	},
	{
		"name": "Ricardo",
		"age": "52 years",
		"situation": "Situation: The Son in Trouble (AI Cloning)",
		"description": "Description: Works under a lot of stress and is always watching out for his children. He is impulsive and acts before thinking when it comes to family emergencies.",
		"vulnerability": "Vulnerability: Protective instinct. Urgency blocks his logical reasoning capacity.",
		"difficulty": "Difficulty Level: 3/5",
		"hint": "Hint: He is skeptical by nature, but his weak point is his son. The key here is speed. If you give him time to think or verify data, you are lost. Success depends on a quick strike."
	},
	{
		"name": "Don Julián",
		"age": "68 years",
		"situation": "Situation: The Fake Bank Manager",
		"description": "Description: Former accountant, very meticulous with his savings. Reads the financial newspaper and believes he knows how banks work, making him feel falsely secure.",
		"vulnerability": "Vulnerability: Fear of financial theft. His savings are his life's work, and any threat to his 'wealth' destabilizes him.",
		"difficulty": "Difficulty Level: 5/5",
		"hint": "Hint: Detects inconsistencies quickly. Knows the basic rules to defend against cybercriminals. You must use very precise banking terminology to make him believe you are the expert."
	}
]

# Variable to know the current contact selected
var current_selected_contact = null

func _ready():
	refresh_contact_list()
	
func refresh_contact_list():
	contact_list.clear()
	
	var available_profiles = []
	
	for profile in profiles:
		if not GlobalData.victims_hacked.has(profile["name"]):
			available_profiles.append(profile)
	
	profiles = available_profiles
	
	for profile in profiles:
		contact_list.add_item(profile["name"])
	
	if profiles.size() > 0:
		contact_list.select(0)
		_on_item_list_item_selected(0)
	else:
		lbl_name.text = "No more targets"
		lbl_situation.text = ""
		lbl_description.text = "You have successfully hacked all available contacts."
		lbl_vulnerability.text = ""
		lbl_difficulty.text = ""
		lbl_hint.text = ""
		btn_call.disabled = true

# Function called when you click a name on the left list
func _on_item_list_item_selected(index: int):
	var profile = profiles[index]
	current_selected_contact = profile
	
	# Update the labels on the right
	lbl_name.text = profile["name"] + " (" + profile["age"] + ")"
	lbl_situation.text = profile["situation"]
	lbl_description.text = profile["description"]
	lbl_vulnerability.text = profile["vulnerability"]
	lbl_difficulty.text = profile["difficulty"]
	lbl_hint.text = profile["hint"]

func _on_call_button_pressed():
	match current_selected_contact["name"]:
		"Matilde":
			get_tree().change_scene_to_file("res://scenes/Computer/Programs & Icons/ContactCalls/ContactMatilde.tscn")
			
			
		"Ricardo":
			get_tree().change_scene_to_file("res://scenes/Computer/Programs & Icons/ContactCalls/ContactRicardo.tscn")
			
			
		"Don Julián":
			get_tree().change_scene_to_file("res://scenes/Computer/Programs & Icons/ContactCalls/ContactMrJulian.tscn")
