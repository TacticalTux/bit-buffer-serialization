local TextBoxType = {}

TextBoxType.Properties = {
	{"ClearTextOnFocus", "Bool", true},
	{"MultiLine", "Bool", false},
	{"PlaceholderColor3", "Color3", Color3.fromRGB(178, 178, 178)},
	{"PlaceholderText", "String", ""}
}

TextBoxType.Provides = {
	["TextBox"] = 30,
}

TextBoxType.Requires = {
	"GuiText"
}

return TextBoxType