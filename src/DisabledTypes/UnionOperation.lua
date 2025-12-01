-- Requires PartTagger, not included in public release.

local UnionOperationType = {}

UnionOperationType.Properties = {
	{"PartTag", "Attribute", "nil"}
}

UnionOperationType.Provides = {
	["UnionOperation"] = 22,
}

UnionOperationType.Requires = {
	"BasePart",
}

UnionOperationType.InstanceNameOverride = "Part"

return UnionOperationType