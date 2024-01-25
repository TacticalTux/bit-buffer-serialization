local InstanceType = {}

InstanceType.Properties = {
	{"Parent", "Instance", nil, 1},
	{"Name", "String", "Part"}
}

InstanceType.Provides = {
	["InstanceType"] = 1,
	["Folder"] = 19
}

InstanceType.Requires = {
	"DefaultType",
}

return InstanceType