extends Container


@export var player : Player
@export_file("*.tscn") var stat_panel_path

var export_variables : Array[String]

# Called when the node enters the scene tree for the first time.
func _ready():
	var stat_panel_resource = load(stat_panel_path)
	
	for p in player.get_property_list():
		if p.usage == 4102 and (p.type == 3 or p.type == 2):
			export_variables.append(p.name)
		
	for v in export_variables:
		var stat_panel = stat_panel_resource.instantiate()
		stat_panel.property = v
		add_child(stat_panel)


func _on_button_toggled(button_pressed):
	visible = button_pressed
