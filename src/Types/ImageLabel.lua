local ImageLabelType = {}

-- i am too lazy to add 9 slice support at the moment add it later plz

ImageLabelType.Properties = {
	{"Image", "String", ""},
	{"ImageColor3", "Color3", Color3.fromRGB(255, 255, 255)},
	{"ImageRectOffset", "Vector2", Vector2.new(0, 0)},
	{"ImageRectSize", "Vector2", Vector2.new(0, 0)},
	{"ImageTransparency", "Float32", 0},
	{"ScaleType", "Value", Enum.ScaleType.Stretch, 4},
}

ImageLabelType.Provides = {
	["ImageLabel"] = 27,
}

ImageLabelType.Requires = {
	"GuiObjectType",
}

return ImageLabelType