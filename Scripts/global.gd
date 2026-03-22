extends Node

var score_j1 = 0.0
var score_j2 = 0.0

var timer = 5

var keys_state = {
	# ── Player 1 ──────────────────────────────────────────
	# Rangée QWERT
	"q" : {
		"player" : 1,
		"line" : 1,
		"col" : 0,
		"state" : true,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"w" : {
		"player" : 1,
		"line" : 1,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"e" : {
		"player" : 1,
		"line" : 1,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"r" : {
		"player" : 1,
		"line" : 1,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"t" : {
		"player" : 1,
		"line" : 1,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	# Rangée ASDFG
	"a" : {
		"player" : 1,
		"line" : 2,
		"col" : 0,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"s" : {
		"player" : 1,
		"line" : 2,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"d" : {
		"player" : 1,
		"line" : 2,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"f" : {
		"player" : 1,
		"line" : 2,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"g" : {
		"player" : 1,
		"line" : 2,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	# Rangée YXCVB
	"y" : {
		"player" : 1,
		"line" : 3,
		"col" : 0,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"x" : {
		"player" : 1,
		"line" : 3,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"c" : {
		"player" : 1,
		"line" : 3,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"v" : {
		"player" : 1,
		"line" : 3,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"b" : {
		"player" : 1,
		"line" : 3,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},

	# ── Player 2 ──────────────────────────────────────────
	# Rangée ZUIOP
	"z" : {
		"player" : 2,
		"line" : 1,
		"col" : 0,
		"state" : true,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"u" : {
		"player" : 2,
		"line" : 1,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"i" : {
		"player" : 2,
		"line" : 1,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"o" : {
		"player" : 2,
		"line" : 1,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"p" : {
		"player" : 2,
		"line" : 1,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	# Rangée HJKLé
	"h" : {
		"player" : 2,
		"line" : 2,
		"col" : 0,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"j" : {
		"player" : 2,
		"line" : 2,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"k" : {
		"player" : 2,
		"line" : 2,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"l" : {
		"player" : 2,
		"line" : 2,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"é" : {
		"player" : 2,
		"line" : 2,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	# Rangée NM,.-
	"n" : {
		"player" : 2,
		"line" : 3,
		"col" : 0,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"m" : {
		"player" : 2,
		"line" : 3,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"," : {
		"player" : 2,
		"line" : 3,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"point" : {
		"player" : 2,
		"line" : 3,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
	"-" : {
		"player" : 2,
		"line" : 3,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "noevent",
	},
}

var powers_available_j1 = false
var powers_available_j2 = false

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

var text_j1 = "..."
var text_j2 = "..."

var current_floor_j1 = 0
var current_floor_j2 = 0

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
