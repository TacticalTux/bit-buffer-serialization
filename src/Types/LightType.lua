local LightType = {}

LightType.Properties = {
	{"Brightness", "Float32", 1},
	{"Color", "Color3", Color3.fromRGB(255, 255, 255)},
	{"Enabled", "Bool", true},
	{"Shadows", "Bool", false},
	{"Range", "Float32", 8}
}

LightType.Provides = {
	["LightType"] = 11,
	["PointLight"] = 12,
}

LightType.Requires = {
	"InstanceType"
}

return LightType