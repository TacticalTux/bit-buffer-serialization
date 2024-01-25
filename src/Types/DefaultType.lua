local DefaultType = {}

-- this one is MANDATORY!!!!

DefaultType.Properties = {
	-- The length for these values is hardcoded in the deserialization section btw
	{"__TypeId", "UnsignedInt", -1, 12}, -- 4096 supported types
}

-- Included for example, but matters. All items should require DefaultType as the first item, somewhere in their tree.
-- DefaultType.Requires = {}

DefaultType.Provides = {
	["DefaultType"] = 0,
}

return DefaultType
