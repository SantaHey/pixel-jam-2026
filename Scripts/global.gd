extends Node

var score_j1 = 0.0
var score_j2 = 0.0

var keys_state = {
	# ── Player 1 ──────────────────────────────────────────
	# Chiffres 1-5
	"1" : {
		"player" : 1,
		"line" : 0,
		"col" : 0,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"2" : {
		"player" : 1,
		"line" : 0,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"3" : {
		"player" : 1,
		"line" : 0,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"4" : {
		"player" : 1,
		"line" : 0,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"5" : {
		"player" : 1,
		"line" : 0,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	# Rangée QWERT
	"q" : {
		"player" : 1,
		"line" : 1,
		"col" : 0,
		"state" : true,
		"multiplicator" : 1,
		"pressed" : false
	},
	"w" : {
		"player" : 1,
		"line" : 1,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"e" : {
		"player" : 1,
		"line" : 1,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"r" : {
		"player" : 1,
		"line" : 1,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"t" : {
		"player" : 1,
		"line" : 1,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	# Rangée ASDFG
	"a" : {
		"player" : 1,
		"line" : 2,
		"col" : 0,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"s" : {
		"player" : 1,
		"line" : 2,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"d" : {
		"player" : 1,
		"line" : 2,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"f" : {
		"player" : 1,
		"line" : 2,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"g" : {
		"player" : 1,
		"line" : 2,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	# Rangée YXCVB
	"y" : {
		"player" : 1,
		"line" : 3,
		"col" : 0,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"x" : {
		"player" : 1,
		"line" : 3,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"c" : {
		"player" : 1,
		"line" : 3,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"v" : {
		"player" : 1,
		"line" : 3,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"b" : {
		"player" : 1,
		"line" : 3,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},

	# ── Player 2 ──────────────────────────────────────────
	# Chiffres 6-0
	"6" : {
		"player" : 2,
		"line" : 0,
		"col" : 0,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"7" : {
		"player" : 2,
		"line" : 0,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"8" : {
		"player" : 2,
		"line" : 0,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"9" : {
		"player" : 2,
		"line" : 0,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"0" : {
		"player" : 2,
		"line" : 0,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	# Rangée ZUIOP
	"z" : {
		"player" : 2,
		"line" : 1,
		"col" : 0,
		"state" : true,
		"multiplicator" : 1,
		"pressed" : false
	},
	"u" : {
		"player" : 2,
		"line" : 1,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"i" : {
		"player" : 2,
		"line" : 1,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"o" : {
		"player" : 2,
		"line" : 1,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"p" : {
		"player" : 2,
		"line" : 1,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	# Rangée HJKLé
	"h" : {
		"player" : 2,
		"line" : 2,
		"col" : 0,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"j" : {
		"player" : 2,
		"line" : 2,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"k" : {
		"player" : 2,
		"line" : 2,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"l" : {
		"player" : 2,
		"line" : 2,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"é" : {
		"player" : 2,
		"line" : 2,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	# Rangée NM,.-
	"n" : {
		"player" : 2,
		"line" : 3,
		"col" : 0,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"m" : {
		"player" : 2,
		"line" : 3,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"," : {
		"player" : 2,
		"line" : 3,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"point" : {
		"player" : 2,
		"line" : 3,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
	"-" : {
		"player" : 2,
		"line" : 3,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false
	},
}

var powers_available = true

var powers_state = {
	"1" : {
		"player" : 1,
	},
	"2" : {
		"player" : 1,
	},
	"3" : {
		"player" : 1,
	}
}

var current_floor = 0

var floors = {
	0 : {
		"base_value" : 0.0,
		"reach_value" : 100.0,
	},
	1 : {
		"base_value" : 100.0,
		"reach_value" : 200.0,
	},
	2 : {
		"base_value" : 200.0,
		"reach_value" : INF,
	},
}
