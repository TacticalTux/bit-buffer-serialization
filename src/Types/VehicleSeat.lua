local VehicleSeat = {}

VehicleSeat.Properties = {
	{"MaxSpeed", "Float32", 25},
	{"Torque", "Float32", 10},
	{"TurnSpeed", "Float32", 1},
}

VehicleSeat.Provides = {
	["VehicleSeat"] = 4,
}

VehicleSeat.Requires = {
	"BasePart"
}

return VehicleSeat