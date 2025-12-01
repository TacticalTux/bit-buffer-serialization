-- Requires PartTagger, not included in public release.

local MeshPartType = {}

MeshPartType.Properties = {
	{"PartTag", "Attribute", "nil"},
	{"MeshId", "Attribute", "nil"}
}

MeshPartType.Provides = {
	["MeshPart"] = 23
}

MeshPartType.Requires = {
	"BasePart",
}

MeshPartType.InstanceNameOverride = "Part"

return MeshPartType