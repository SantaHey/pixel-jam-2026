extends Node

var score_j1 = 0
var score_j2 = 0


var keys_state = {
	# Player 1
	"q" : {
		"player" : 1,
		"line" : 0,
		"col" : 0,
		"state" : true,
		"multiplicator" : 1,
		"pressed" : false
	},
	"w" : {
		"player" : 1,
		"line" : 0,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	# Player 2
	"z" : {
		"player" : 2,
		"line" : 0,
		"col" : 0,
		"state" : true,
		"multiplicator" : 1,
		"pressed" : false
	},
	"u" : {
		"player" : 2,
		"line" : 0,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
}
