extends Node2D

var test_array: Array[String] = ["Test","sauce","stuff"]
# Called when the node enters the scene tree for the first time.
	
	
func test_function():
	pass


func _on_area_2d_body_entered(_body):
	print("body has entered")


func _on_area_2d_body_exited(_body):
	print("body has exited")

