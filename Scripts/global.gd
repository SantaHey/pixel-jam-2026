extends Node

var score_j1 = 0.0
var score_j2 = 0.0

var timer = 10

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
		"event" : "normal",
	},
	"w" : {
		"player" : 1,
		"line" : 1,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"e" : {
		"player" : 1,
		"line" : 1,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"r" : {
		"player" : 1,
		"line" : 1,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"t" : {
		"player" : 1,
		"line" : 1,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	# Rangée ASDFG
	"a" : {
		"player" : 1,
		"line" : 2,
		"col" : 0,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"s" : {
		"player" : 1,
		"line" : 2,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"d" : {
		"player" : 1,
		"line" : 2,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"f" : {
		"player" : 1,
		"line" : 2,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"g" : {
		"player" : 1,
		"line" : 2,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	# Rangée YXCVB
	"y" : {
		"player" : 1,
		"line" : 3,
		"col" : 0,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"x" : {
		"player" : 1,
		"line" : 3,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"c" : {
		"player" : 1,
		"line" : 3,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"v" : {
		"player" : 1,
		"line" : 3,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"b" : {
		"player" : 1,
		"line" : 3,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
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
		"event" : "normal",
	},
	"u" : {
		"player" : 2,
		"line" : 1,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"i" : {
		"player" : 2,
		"line" : 1,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"o" : {
		"player" : 2,
		"line" : 1,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"p" : {
		"player" : 2,
		"line" : 1,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	# Rangée HJKLé
	"h" : {
		"player" : 2,
		"line" : 2,
		"col" : 0,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"j" : {
		"player" : 2,
		"line" : 2,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"k" : {
		"player" : 2,
		"line" : 2,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"l" : {
		"player" : 2,
		"line" : 2,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"é" : {
		"player" : 2,
		"line" : 2,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	# Rangée NM,.-
	"n" : {
		"player" : 2,
		"line" : 3,
		"col" : 0,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"m" : {
		"player" : 2,
		"line" : 3,
		"col" : 1,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"," : {
		"player" : 2,
		"line" : 3,
		"col" : 2,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"point" : {
		"player" : 2,
		"line" : 3,
		"col" : 3,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
	},
	"-" : {
		"player" : 2,
		"line" : 3,
		"col" : 4,
		"state" : false,
		"multiplicator" : 1,
		"pressed" : false,
		"event" : "normal",
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
