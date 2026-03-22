extends Node

# ─────────────────────────────
# DECLARATION
# ─────────────────────────────

var score_j1
var score_j2

var timer

var winner

var keys_state

var powers_available_j1
var powers_available_j2

var powers_state

var text_j1
var text_j2

var current_floor_j1
var current_floor_j2

var floors


# ─────────────────────────────
# INITIALISATION
# ─────────────────────────────
func init():

	score_j1 = 0.0
	score_j2 = 0.0

	timer = 150

	winner = 0

	keys_state = {
		# ── Player 1 ──────────────────────────────────────────
		# Rangée QWERT
		"q" : {
			"player" : 1,
			"line" : 1,
			"col" : 0,
			"state" : false,
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
			"state" : false,
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

	powers_available_j1 = false
	powers_available_j2 = false

	powers_state = {
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

	text_j1 = "..."
	text_j2 = "..."

	current_floor_j1 = 0
	current_floor_j2 = 0

	floors = {
		0 : {
			"base_value" : 0.0,
			"reach_value" : 100.0,
		},
		1 : {
			"base_value" : 100.0,
			"reach_value" : 300.0,
		},
		2 : {
			"base_value" : 300.0,
			"reach_value" : 900.,
		},
		3 : {
			"base_value" : 900.0,
			"reach_value" : 2700.0,
		},
		4 : {
			"base_value" : 2700.0,
			"reach_value" : 8100,
		},
		5: {
			"base_value" : 8100.0,
			"reach_value" : 10000.0,
		},
		6 : {
			"base_value" : 10000.0,
			"reach_value" : 15000.0,
		},
		7 : {
			"base_value" : 15000.0,
			"reach_value" : 20000.0,
		},
		8 : {
			"base_value" : 20000.0,
			"reach_value" : 25000.0,
		},
		9 : {
			"base_value" : 25000.0,
			"reach_value" : INF,
		},
		10 : {
			"base_value" : 24300.0,
			"reach_value" : INF,
		},
	}
