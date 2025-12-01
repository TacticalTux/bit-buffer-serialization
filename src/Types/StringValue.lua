local StringValueType = {}

StringValueType.Properties = {
	{"Value", "String", ""}
}

StringValueType.Provides = {
	["StringValue"] = 21
}

StringValueType.Requires = {
	"InstanceType",
}

return StringValueType