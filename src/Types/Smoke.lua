local Smoke = {}

Smoke.Properties = {
	{"Enabled", "Bool", true},
	{"Color", "Color3", Color3.fromRGB(255, 255, 255)},
	{"Size", "Float32", 1},
	{"RiseVelocity", "Float32", 1},
	{"Opacity", "Float32", 0.5}
}

Smoke.Provides = {
	["Smoke"] = 15,
}

Smoke.Requires = {
	"InstanceType"
}

return Smoke