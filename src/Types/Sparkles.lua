local Sparkles = {}

Sparkles.Properties = {
	{"Enabled", "Bool", true},
	{"SparkleColor", "Color3", Color3.fromRGB(144, 25, 255)}
}

Sparkles.Provides = {
	["Sparkles"] = 17,
}

Sparkles.Requires = {
	"InstanceType"
}

return Sparkles