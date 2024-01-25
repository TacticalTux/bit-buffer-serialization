local Part = {}

Part.Properties = {
	{"Shape", "Value", Enum.PartType.Block, 2},
}

Part.Provides = {
	["Part"] = 3,
}

Part.Requires = {
	"BasePart"
}

return Part