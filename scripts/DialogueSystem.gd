extends Control

const DialogueButtonPreload = preload("res://scenes/DialogueButton.tscn")

@onready var DialogueLabel: RichTextLabel = $HBoxContainer/VBoxContainer/RichTextLabel
@onready var SpeakerSprite: Sprite2D = $HBoxContainer/SpeakerParent/Sprite2D

var dialogue: Array[DE]
var current_dialogue_item: int = 0
var next_item: bool = true

var player_node: CharacterBody2D = null

func _ready():
	visible = false
	$HBoxContainer/VBoxContainer/button_container.visible = false
	
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player_node = players[0]
		player_node.can_move = false

func _process(delta):
	if current_dialogue_item == dialogue.size():
		if player_node:
			player_node.can_move = true
		queue_free()
		return
	
	if next_item:
		next_item = false
		var i = dialogue[current_dialogue_item]
		
		if i is DialogueChoice:
			visible = true
			_choice_resource(i)
		
		elif i is DialogueText:
			visible = true
			_text_resource(i)
		
		else:
			current_dialogue_item += 1
			next_item = true

func _choice_resource(i: DialogueChoice):
	DialogueLabel.text = i.text
	DialogueLabel.visible_characters = -1
	if i.speaker_img:
		$HBoxContainer/SpeakerParent.visible = true
		SpeakerSprite.texture = i.speaker_img
		SpeakerSprite.hframes = i.speaker_img_Hframes
		SpeakerSprite.frame = min(i.speaker_img_select_frame, i.speaker_img_Hframes-1)
	else:
		$HBoxContainer/SpeakerParent.visible = false
	$HBoxContainer/VBoxContainer/button_container.visible = true
	
	for item in i.choice_text.size():
		var DialogueButtonVar = DialogueButtonPreload.instantiate()
		DialogueButtonVar.text = i.choice_text[item]
		DialogueButtonVar.pressed.connect(_choice_button_pressed)
		
		$HBoxContainer/VBoxContainer/button_container.add_child(DialogueButtonVar)
	$HBoxContainer/VBoxContainer/button_container.get_child(0).grab_focus()

func _choice_button_pressed():
	$HBoxContainer/VBoxContainer/button_container.visible = false
	for i in $HBoxContainer/VBoxContainer/button_container.get_children():
		i.queue_free()
	
	current_dialogue_item += 1
	next_item = true

func _text_resource(i: DialogueText):
	$AudioStreamPlayer.stream = i.text_sound
	$AudioStreamPlayer.volume_db = i.text_volume_db
	var camera: Camera2D = get_viewport().get_camera_2d()
	if camera and i.camera_position != Vector2(999.999, 999.999):
		var camera_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
		camera_tween.tween_property(camera, "global_position", i.camera_position, i.camera_transition_time)

	if !i.speaker_img:
		$HBoxContainer/SpeakerParent.visible = false
	else:
		$HBoxContainer/SpeakerParent.visible = true
		SpeakerSprite.texture = i.speaker_img
		SpeakerSprite.hframes = i.speaker_img_Hframes
		SpeakerSprite.frame = 0
	
	DialogueLabel.visible_characters = 0
	DialogueLabel.text = i.text
	
	var text_without_square_brackets: String = _text_without_square_brackets(i.text)
	var total_characters: int = text_without_square_brackets.length()
	var character_timer: float = 0.0
	
	while DialogueLabel.visible_characters < total_characters:
		if Input.is_action_just_pressed("ui_cancel"):
			DialogueLabel.visible_characters = total_characters
			break
		
		character_timer += get_process_delta_time()
		if character_timer >= (1.0 / i.text_speed) or text_without_square_brackets[DialogueLabel.visible_characters] == " ":
			var character: String = text_without_square_brackets[DialogueLabel.visible_characters]
			DialogueLabel.visible_characters += 1
			if character != " ":
				$AudioStreamPlayer.pitch_scale = randf_range(i.text_volume_pitch_min, i.text_volume_pitch_max)
				$AudioStreamPlayer.play()
				if i.speaker_img_Hframes != 1:
					if SpeakerSprite.frame < i.speaker_img_Hframes - 1:
						SpeakerSprite.frame += 1
					else:
						SpeakerSprite.frame = 0
			character_timer = 0.0
		
		await get_tree().process_frame
		
	SpeakerSprite.frame = min(i.speaker_img_rest_frame, i.speaker_img_Hframes-1)
	
	while true:
		await get_tree().process_frame
		if DialogueLabel.visible_characters == total_characters:
			if Input.is_action_just_pressed("ui_accept"):
				current_dialogue_item += 1
				next_item = true
				break

func _text_without_square_brackets(text: String):
	var result = ""
	var inside_bracket = false
	
	for i in text:
		if i == "[":
			inside_bracket = true
			continue
		
		if i == "]":
			inside_bracket = false
			continue
		
		if !inside_bracket:
			result += i
	
	return result
