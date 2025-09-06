@tool
extends VBoxContainer

var data = []

var attributionsNode := preload("res://Credits/Sections/Attributions/attributions_credit.tscn")
var CRSep := preload("res://Credits/Sections/Seperators/CR_Seperator.tscn")

func _ready() -> void:
	#print(data)
	#print(Engine.get_author_info())
	var cpriteInfo=Engine.get_copyright_info()
	for a in cpriteInfo:
		print(a)
	data+=cpriteInfo
		
	$Tile.text = "Attributions"
	var colms = $ColumnCredits
	var Number = data.size()-1
	var count = 0;
	for author in data:
		var authorCredit = attributionsNode.instantiate()
		
		authorCredit.attribName=author["name"]
		authorCredit.copyright = ""
		authorCredit.license = ""
		for part in author["parts"]:
				for i in part["copyright"].size():
					authorCredit.copyright+=part["copyright"][i]
					authorCredit.copyright+="\n"
				authorCredit.license=part["license"]
		colms.add_child(authorCredit)
		if(count<Number):
			colms.add_child(CRSep.instantiate())
		count+=1
		
	#pass
