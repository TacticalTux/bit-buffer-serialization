local ParticleEmitterType = {}

ParticleEmitterType.Properties = {
	{"Acceleration", "Vector3", Vector3.new(0, 0, 0)},
	{"Brightness", "Float32", 1},
	{"Color", "ColorSequence", ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255))},
	{"Drag", "Float32", 0},
	{"EmissionDirection", "Value", Enum.NormalId.Top, 4},
	{"Enabled", "Bool", true},
	{"Lifetime", "NumberRange", NumberRange.new(5, 10)},
	{"LightEmission", "Float32", 0},
	{"LightInfluence", "Float32", 1},
	{"LockedToPart", "Bool", false},
	{"Orientation", "Value", Enum.ParticleOrientation.FacingCamera, 3},
	{"Rate", "Float32", 20},
	{"RotSpeed", "NumberRange", NumberRange.new(0, 0)},
	{"Rotation", "NumberRange", NumberRange.new(0, 0)},
	{"Shape", "Value", Enum.ParticleEmitterShape.Box, 3},
	{"ShapeInOut", "Value", Enum.ParticleEmitterShapeInOut.Outward, 3},
	{"ShapeStyle", "Value", Enum.ParticleEmitterShapeStyle.Volume, 3},
	{"Size", "NumberSequence", NumberSequence.new(0, 0)},
	{"Speed", "NumberRange", NumberRange.new(5, 5)},
	{"SpreadAngle", "Vector2", Vector2.new(0, 0)},
	{"Squash", "NumberSequence", NumberSequence.new(0, 0)},
	{"Texture", "String", ""},
	{"TimeScale", "Float32", 1},
	{"Transparency", "NumberSequence", NumberSequence.new(0, 0)},
	{"VelocityInheritance", "Float32", 0},
	{"WindAffectsDrag", "Bool", false},
	{"ZOffset", "Float64", 0}
}

ParticleEmitterType.Provides = {
	["ParticleEmitter"] = 31,
}

ParticleEmitterType.Requires = {
	"InstanceType"
}

return ParticleEmitterType