-- this is just a fake type used for text labels and text boxes

--[[
{"Font", "RichText", "Text", "TextColor3", "TextScaled", "TextStrokeColor3", "TextStrokeTransparency", "TextTransparency", "TextTruncate",
		"TextWrapped", "TextXAlignment", "TextYAlignment", "LineHeight", "MaxVisibleGraphemes", "TextSize"}
]]

local GuiTextType = {}

GuiTextType.Properties = {
	{"Font", "Value", Enum.Font.SourceSans, 32},
	{"Text", "String", "GuiText"},
	{"RichText", "Bool", false},
	{"TextColor3", "Color3", Color3.fromRGB(0, 0, 0)},
	{"TextScaled", "Bool", false},
	{"TextStrokeColor3", "Color3", Color3.fromRGB(0, 0, 0)},
	{"TextStrokeTransparency", "Float32", 1},
	{"TextTransparency", "Float32", 0},
	{"TextTruncate", "Value", Enum.TextTruncate.None, 3},
	{"TextWrapped", "Bool", false},
	{"TextXAlignment", "Value", Enum.TextXAlignment.Center, 3},
	{"TextYAlignment", "Value", Enum.TextYAlignment.Center, 3},
	{"LineHeight", "Float32", 1},
	{"MaxVisibleGraphemes", "Int", -1, 32},
	{"TextSize", "UnsignedInt", 14, 7}
}

GuiTextType.Provides = {
	["GuiText"] = 28,
	["TextLabel"] = 29
}

GuiTextType.Requires = {"GuiObjectType"}

return GuiTextType