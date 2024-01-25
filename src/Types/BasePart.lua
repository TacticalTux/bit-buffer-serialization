local BasePartType = {}

BasePartType.Properties = {
	{"CastShadow", "Bool", true},
	{"Position", "Vector3", Vector3.new(0, 0, 0)},
	{"Orientation", "Vector3", Vector3.new(0, 0, 0)},
	{"Size", "Vector3", Vector3.new(1, 0.4, 1)},
	{"Color", "Color3", Color3.fromRGB(163, 162, 165)},
	{"Material", "Value", Enum.Material.Plastic, 12},
	{"Anchored", "Bool", true},
	{"CanCollide", "Bool", true},
	{"Reflectance", "Float32", 0},
	{"Transparency", "Float32", 0},
	{"TopSurface", "Value", Enum.SurfaceType.Smooth, 4},
	{"FrontSurface", "Value", Enum.SurfaceType.Smooth, 4},
	{"LeftSurface", "Value", Enum.SurfaceType.Smooth, 4},
	{"RightSurface", "Value", Enum.SurfaceType.Smooth, 4},
	{"BackSurface", "Value", Enum.SurfaceType.Smooth, 4},
	{"BottomSurface", "Value", Enum.SurfaceType.Smooth, 4},
}

-- The requires table tells the above module what this is looking for.
BasePartType.Requires = {
	"InstanceType"
}

-- the entry for part is temp
BasePartType.Provides = {
	["BasePart"] = 2,
	["WedgePart"] = 6,
	["CornerWedgePart"] = 7,
	["Seat"] = 20
}

return BasePartType