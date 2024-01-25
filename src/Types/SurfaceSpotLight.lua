local SurfaceSpotLight = {}

SurfaceSpotLight.Properties = {
	{"Angle", "Float32", 90},
	{"Face", "Value", Enum.NormalId.Front, 3}
}

SurfaceSpotLight.Provides = {
	["SpotLight"] = 13,
	["SurfaceLight"] = 14
}

SurfaceSpotLight.Requires = {
	"LightType"
}

return SurfaceSpotLight