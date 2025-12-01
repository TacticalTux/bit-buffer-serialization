local GuiObjectType = {}

GuiObjectType.Properties = {
	{"Active", "Bool", false},
	{"AnchorPoint", "Vector2", Vector2.new(0, 0)},
	{"AutomaticSize", "Value", Enum.AutomaticSize.None, 3},
	{"BackgroundColor3", "Color3", Color3.fromRGB(255, 255, 255)},
	{"BackgroundTransparency", "Float32", 0},
	{"BorderColor3", "Color3", Color3.fromRGB(0, 0, 0)},
	{"BorderMode", "Value", Enum.BorderMode.Outline, 2},
	{"BorderSizePixel", "UnsignedInt", 0, 16},
	{"LayoutOrder", "Int", 0, 64},
	{"Position", "UDim2", UDim2.new(0, 0, 0, 0)},
	{"Rotation", "Float32", 0},
	{"Size", "UDim2", UDim2.new(0, 100, 0, 100)},
	{"SizeConstraint", "Value", Enum.SizeConstraint.RelativeXY, 2},
	{"Visible", "Bool", true},
	{"ZIndex", "Int", 1, 64},
	{"ClipsDescendants", "Bool", false},
	{"Selectable", "Bool", false},
}

GuiObjectType.Provides = {
	["GuiObjectType"] = 24,
	["Frame"] = 25
}

GuiObjectType.Requires = {
	"InstanceType",
}

return GuiObjectType