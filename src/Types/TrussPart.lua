local TrussPart = {}

TrussPart.Properties = {
	{"Style", "Value", Enum.Style.AlternatingSupports, 2},
}

TrussPart.Provides = {
	["TrussPart"] = 5,
}

TrussPart.Requires = {
	"BasePart"
}

return TrussPart