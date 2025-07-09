extends Control

var watered_states = ["watered", "dry"]
var crop_types = []

# instantiate Tile and tile_grid
@onready var tile_grid = $tile_grid
var grid_size = Vector2i(12, 10)
var tile_scene = preload("res://Tile/tile.tscn")
var tiles = []  # Optional: store references

func _ready() -> void:
	for y in range(grid_size.y):
		for x in range(grid_size.x):
			var tile = tile_scene.instantiate()
			print(1)
			tile_grid.add_child(tile)
			tiles.append(tile)



func init_farming_area() -> void:
	pass
