local Texture = {}

Texture.Properties = {
	{"StudsPerTileU", "Float32", 2},
	{"StudsPerTileV", "Float32", 2}
}

Texture.Provides = {
	["Texture"] = 10,
}

Texture.Requires = {
	"Decal"
}

return Texture