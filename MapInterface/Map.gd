extends Node2D

export var numbers_of_nivels= 4

onready var players = $MapPointer
var positions=[]
var nivels=[]

func _ready():
	for i in range(1,numbers_of_nivels+1):
		var levelIcon = get_node("LevelIcon"+str(i))
		nivels.append(levelIcon.level_number)
		positions.append(levelIcon.global_position)
		
	#var current_level=Globals.current_level
	#print(players.global_position)
	#for i in range(0,4):
#		if nivels[i]==current_level:
		#	print(nivels[i])
		#	var pos = positions[i]
		#	players.global_position=pos
		#	break
#	print(players.global_position)

			
			
			
	
		
