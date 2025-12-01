local SurfaceGuiType = {}

SurfaceGuiType.Properties = {
	{"Active", "Bool", true},
	{"Adornee", "Instance", nil, 0},
	{"AlwaysOnTop", "Bool", false},
	{"Face", "Value", Enum.NormalId.Front, 3},
	{"LightInfluence", "Float64", 1},
	{"Brightness", "Float64", 1},
	{"Enabled", "Bool", true},
	{"ResetOnSpawn", "Bool", true},
	{"ZIndexBehavior", "Value", Enum.ZIndexBehavior.Sibling, 2},
	{"ClipsDescendants", "Bool", true},
	{"PixelsPerStud", "Float64", 50},
	{"CanvasSize", "Vector2", Vector2.new(800, 600)},
	{"SizingMode", "Value", Enum.SurfaceGuiSizingMode.PixelsPerStud, 2}
}

SurfaceGuiType.Provides = {
	["SurfaceGui"] = 26,
}

SurfaceGuiType.Requires = {
	"InstanceType",
}

return SurfaceGuiType