@tool
extends Control

enum Sections {
	Developers,
	Attributions,
}
var developersSection = preload("res://Credits/Sections/Developers/section_credits.tscn")
#var attributionsSection = preload("res://Credits/Sections/Attributions/section_attributions.tscn")

func _ready():
	# read in credits file
	var credits := FileAccess.open("res://Credits/Credits.yml",FileAccess.READ).get_as_text()
	var result:=YAML.parse(credits)
	if result.has_error():
		push_error(result.get_error());
		return
	var data = result.get_data()
# TODO: make Title UI lable to instantiate

	for Section in data:
		%CreditsBox/VBoxContainer.add_child(createCreditsSection(data[Section],Sections.get(Section)))



func createCreditsSection(rolesinfo,sectionType:Sections):
	var sec
	match sectionType:
		Sections.Developers:
			sec = developersSection.instantiate()
		#Sections.Attributions:
			#sec = attributionsSection.instantiate()
			
	sec.data = rolesinfo
	return sec
	
