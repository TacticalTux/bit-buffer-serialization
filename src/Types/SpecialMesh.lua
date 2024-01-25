local SpecialMesh = {}

SpecialMesh.Properties = {
	{"MeshType", "Value", Enum.MeshType.Head, 4},
	{"MeshId", "RBXAssetId", ""},
	{"TextureId", "RBXAssetId", ""},
	{"Offset", "Vector3", Vector3.new(0, 0, 0)},
	{"Scale", "Vector3", Vector3.new(1, 1, 1)},
	{"VertexColor", "Vector3", Vector3.new(1, 1, 1)}
}

SpecialMesh.Provides = {
	["SpecialMesh"] = 8,
}

SpecialMesh.Requires = {
	"InstanceType"
}

return SpecialMesh