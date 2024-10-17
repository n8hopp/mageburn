extends PanelContainer

func _make_custom_tooltip(for_text):
	var tooltip = preload("res://scenes/ui/tooltip.tscn").instantiate()
	tooltip.get_node("MarginContainer/NMLabel").text = for_text
	return tooltip
