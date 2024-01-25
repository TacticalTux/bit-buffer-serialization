local Decal = {}

Decal.Properties = {
	{"Texture", "RBXAssetId", ""},
	{"Transparency", "Float32", 0},
	{"Face", "Value", Enum.NormalId.Front, 3}
}

Decal.Provides = {
	["Decal"] = 9,
}

Decal.Requires = {
	"InstanceType"
}

return Decal