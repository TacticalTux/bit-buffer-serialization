local Fire = {}

Fire.Properties = {
	{"Enabled", "Bool", true},
	{"Color", "Color3", Color3.fromRGB(236, 139, 70)},
	{"SecondaryColor", "Color3", Color3.fromRGB(139, 80, 55)},
	{"Heat", "Float32", 9},
	{"Size", "Float32", 5}
}

Fire.Provides = {
	["Fire"] = 16,
}

Fire.Requires = {
	"InstanceType"
}

return Fire