@tool
extends Control

enum Sections {
	Developers,
	Attributions,
}
var developersSection = preload("res://Credits/Sections/Developers/section_credits.tscn")
var attributionsSection = preload("res://Credits/Sections/Attributions/section_attributions.tscn")

var sectionSeperator = preload("res://Credits/Sections/Seperators/Section_Seperator.tscn")

func _ready():
	# read in credits file
	var creditsFile := FileAccess.open("res://Credits/Credits.json",FileAccess.READ).get_as_text()
	var credits:=JSON.new()
	var result = credits.parse(creditsFile)
	var data = []
	if result!=OK:
		push_error("Error Parsing Credits File");
		return
	else:
		data = credits.data
# TODO: make Title UI lable to instantiate
	for Section in data:
		%CreditsBox/VBoxContainer.add_child(createCreditsSection(data[Section],Sections.get(Section)))
		%CreditsBox/VBoxContainer.add_child(sectionSeperator.instantiate())

func _process(delta: float) -> void:
	if(!Engine.is_editor_hint()):
		%CreditsBox.position.y -=50*delta
		pass


func createCreditsSection(rolesinfo,sectionType:Sections):
	var sec
	match sectionType:
		Sections.Developers:
			sec = developersSection.instantiate()
		Sections.Attributions:
			sec = attributionsSection.instantiate()
			
	sec.data = rolesinfo
	return sec
	
