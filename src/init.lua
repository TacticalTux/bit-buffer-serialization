-- Written by kaz_iaa 2023
-- Distributed under the MIT license

local BitBufferSerialization = {}
BitBufferSerialization.Epoch = 4 -- if theres a change that breaks older strings, use this to differentiate.

--[[
FUTURE TODO:
1. Make an enum type because thing like enum values are stupid and make us take more bits than we need to
2. Use a better system than the fixed length id to refer to parents
3. Make the write value and no write value types for special types (like asset ids) separate things, maybe?
]]

local BitBuffer = require(script.BitBuffer)
local TypeFolder = script:WaitForChild("Types")

-- Build our types table
local Types = {}
local LoadingTypes = {}
local TypeToId = {} -- used temp in loading for efficiency, cleared after

for _, Module in ipairs(TypeFolder:GetChildren()) do
	local ThisType = require(Module)
	
	-- Find what it provides, update the LoadingTypes table.
	for ProvidingString, Id in pairs(ThisType.Provides) do
		-- ensure we don't overlap
		if LoadingTypes[Id] ~= nil then
			error(ProvidingString .. " attempted to overwrite " .. LoadingTypes[Id].Name .. " at Id " .. Id .. ". Erroring.")
		end
		
		-- if it doesn't overlap, write our table for this loaded type
		LoadingTypes[Id] = {
			["Name"] = ProvidingString,
			["Properties"] = ThisType.Properties, 
			["Requires"] = ThisType["Requires"] and {unpack(ThisType["Requires"])} or nil
		}
	end
end

-- Put modules that have no Requires into the main types instantly
-- Now anything still in LoadingTypes needs a dependency resolved
for Id, TypeData in pairs(LoadingTypes) do
	-- make the type to id table we need this
	TypeToId[TypeData.Name] = Id

	if (not TypeData["Requires"]) or (#TypeData["Requires"] == 0) then
		LoadingTypes[Id] = nil
		Types[Id] = TypeData
	else
		TypeData["RealProperties"] = {} -- Created during runtime as we load dependencies, cleared after.
	end
end

-- Ensure all requires are valid
for _, TypeData in pairs(LoadingTypes) do
	for _, Name in TypeData.Requires do
		assert(TypeToId[Name] ~= nil, TypeData.Name .. " requires type " .. Name .. " which does not exist. Erroring.")
	end
end

-- Now begin looping until we have resolved all relationships.
local Attempts = 0
while true do -- We should never hit 100 subtypes (says me as I am writing this code originally)
	if Attempts > 100 then
		warn("Passed over attempt limit resolving dependencies.")
		warn("All types still loading:")
		for _, TypeData in LoadingTypes do
			warn(TypeData.Name)
		end
		warn("Types: ", Types)
		warn("LoadingTypes: ", LoadingTypes)
		error("Erroring.")
	end

	Attempts += 1


	for Id, TypeData in pairs(LoadingTypes) do
		-- get the first requirement, see if it exists
		local TargetType = Types[TypeToId[TypeData.Requires[1]]]
		if TargetType then
			-- build the table
			for _, PropertyData in ipairs(TargetType.Properties) do
				table.insert(TypeData.RealProperties, PropertyData)
			end

			table.remove(TypeData.Requires, 1)

			-- if the requires table is done, move this type over and stuff
			if #TypeData.Requires == 0 then
				-- copy over the original properties to the end
				for _, PropertyData in ipairs(TypeData["Properties"]) do
					table.insert(TypeData.RealProperties, PropertyData)
				end

				TypeData["Properties"] = TypeData["RealProperties"]
				TypeData["RealProperties"] = nil
				LoadingTypes[Id] = nil
				Types[Id] = TypeData
			end
		end
	end

	-- check to see if we have finished loading types
	if #LoadingTypes == 0 then
		break
	end
end

-- Write our defaults table. This code is very jank and is just pcall spam, but I don't feel like hardcoding

local SearchAssetIdTypes = {
	"rbxassetid://",
	"http://www.roblox.com/asset/??id=",
	"https://www.roblox.com/asset/??id="
}

local WriteAssetIdTypes = {
	"rbxassetid://",
	"http://www.roblox.com/asset/?id=",
	"https://www.roblox.com/asset/?id="
}

-- types table has now been loaded

-- Buffer, Type, Value, Argument
local WriteValueByTypeTable = {
	["Float64"] = function(Buffer, Value, _)
		Buffer:WriteFloat64(Value)
	end,
	["Float32"] = function(Buffer, Value, _)
		Buffer:WriteFloat32(Value)
	end,
	["String"] = function(Buffer, Value, _)
		Buffer:WriteString(Value)
	end,
	["UnsignedInt"] = function(Buffer, Value, Argument)
		Buffer:WriteUInt(Argument, Value)
	end,
	["Value"] = function(Buffer, Value, Argument)
		Buffer:WriteUInt(Argument, Value.Value)
	end,
	["Bool"] = function(Buffer, Value, _)
		Buffer:WriteBool(Value)
	end,
	["Vector3"] = function(Buffer, Value, _)
		Buffer:WriteFloat32(Value.X)
		Buffer:WriteFloat32(Value.Y)
		Buffer:WriteFloat32(Value.Z)
	end,
	["Color3"] = function(Buffer, Value, _)
		Buffer:WriteFloat32(Value.R)
		Buffer:WriteFloat32(Value.G)
		Buffer:WriteFloat32(Value.B)
	end,
	["RBXAssetId"] = function(Buffer, Value, _)
		-- Separate this out to see what format it is in
		local TextureId = 0
		local TextureType = 0
		
		-- find the type of id this is, save that type of id
		for Index, SearchValue in ipairs(SearchAssetIdTypes) do
			local NewValue, Found = string.gsub(Value, SearchValue, "")
			if Found ~= 0 then
				TextureId = tonumber(NewValue) or 0			
				TextureType = Index
				break
			end
		end
		
		-- this should be plenty for the rest of the existence of roblox, i hope
		-- if not just bump this number up
		local TextureIdPart1 = math.floor(TextureId / 100000)
		local TextureIdPart2 = TextureId - (TextureIdPart1 * 100000)
		Buffer:WriteUInt(24, TextureIdPart1)
		Buffer:WriteUInt(17, TextureIdPart2)
		Buffer:WriteUInt(2, TextureType)
	end,
}

-- basically for example it would take "Float32" and write the value to that
local function writeValueByType(Buffer, Type, Value, Argument)
	local CallingType = WriteValueByTypeTable[Type]
	if CallingType then
		WriteValueByTypeTable[Type](Buffer, Value, Argument)
	else
		error("Invalid type " .. Type)
	end
end

-- Buffer, Property
local GetDeserializedValueTable = {
	["Float64"] = function(Buffer, _)
		return Buffer:ReadFloat64()
	end,
	["Float32"] = function(Buffer, _)
		return Buffer:ReadFloat32()
	end,
	["String"] = function(Buffer, _)
		return Buffer:ReadString()
	end,
	["UnsignedInt"] = function(Buffer, Property)
		return Buffer:ReadUInt(Property[4])
	end,
	["Value"] = function(Buffer, Property)
		return Buffer:ReadUInt(Property[4])
	end,
	["Bool"] = function(Buffer, _)
		return Buffer:ReadBool()
	end,
	["Vector3"] = function(Buffer, _)
		local X = Buffer:ReadFloat32()
		local Y = Buffer:ReadFloat32()
		local Z = Buffer:ReadFloat32()
		return Vector3.new(X, Y, Z)
	end,
	["Color3"] = function(Buffer, _)
		local X = Buffer:ReadFloat32()
		local Y = Buffer:ReadFloat32()
		local Z = Buffer:ReadFloat32()
		return Color3.new(X, Y, Z)
	end,
	["Instance"] = function(Buffer, _)
		return Buffer:ReadUInt(32)
	end,
	["RBXAssetId"] = function(Buffer, _)
		-- We have to divide the number into two.
		local TextureIdPart1 = Buffer:ReadUInt(24)
		local TextureIdPart2 = Buffer:ReadUInt(17)
		local TextureType = Buffer:ReadUInt(2)
		
		TextureIdPart1 *= 100000
		local TextureId = TextureIdPart1 + TextureIdPart2
		
		if TextureId == 0 then
			return ""
		else
			return WriteAssetIdTypes[TextureType] .. tostring(TextureId)
		end
	end,
}

-- take the property, read the buffer to get the data, return the value for the property
local OperationCount = 0
local function getDeserializedValue(Buffer, Property)
	OperationCount += 1
	if OperationCount % 200000 == 0 then
		task.wait(0.04)
	end
	
	if Property[2] ~= "Bool" and Property[2] ~= "Instance" and Buffer:ReadBool() then
		return Property[3]
	end
	
	return GetDeserializedValueTable[Property[2]](Buffer, Property)
end

function BitBufferSerialization.Serialize(Items)
	-- loop thru all the items, build a list detailing instance -> id so we have consistent IDs
	local ValidItems = 0
	local ValidItemsTable = {}
	
	for _, Item in ipairs(Items) do
		if TypeToId[Item.ClassName] ~= nil then
			ValidItems += 1
			table.insert(ValidItemsTable, Item)
			-- deserialization
		end
	end
	
	-- Inverse our table for reference below:
	local InstanceToId = {}
	for Index, Item in ipairs(ValidItemsTable) do
		InstanceToId[Item] = Index
	end
	
	-- init our bit buffer
	local Buffer = BitBuffer.new()
	
	-- write our metadata
	--[[
	METADATA:
	First 10 bits are the Epoch number. Very large to ensure it is not possible we make this many actual changes over time :tm:
	Next 32 bits are the item count.
	]]
	Buffer:WriteUInt(10, BitBufferSerialization.Epoch)
	Buffer:WriteUInt(32, ValidItems)
	
	-- now go through this list, using its items and index list, and serialize
	for ItemId, Item in ipairs(ValidItemsTable) do
		if ItemId % 2000 == 0 then
			task.wait(0.06)
		end
		
		local ItemTypeId = TypeToId[Item.ClassName]
		local ItemType = Types[ItemTypeId]
		
		for _, Property in ipairs(ItemType.Properties) do
			-- deal with our object special types ourselves
			if Property[1] == "__TypeId" then
				writeValueByType(Buffer, Property[2], ItemTypeId, Property[4])
			elseif Property[2] == "Instance" then
				-- !!!!!!WE APPLY AN OFFSET OF 1 HERE TO THE INSTANCE REFERENCE!!!!!!
				-- 0 is for nil, 1 is for the root.
				if InstanceToId[Item[Property[1]]] ~= nil then
					writeValueByType(Buffer, "UnsignedInt", InstanceToId[Item[Property[1]]] + 1, 32)
				else
					writeValueByType(Buffer, "UnsignedInt", Property[4], 32)
				end
			else -- if it wasn't any of these, it's a normal thing we should write
				-- btw this is the main code that makes it instance only, if this was changed theoretically it could be used
				-- for other stuff xd?
				-- or nil is to make it explicit
				if Property[2] ~= "Bool" and Property[3] == Item[Property[1]] then
					-- this is a default value!!!
					Buffer:WriteBool(true)
				else
					if Property[2] ~= "Bool" then
						Buffer:WriteBool(false)
					end
					writeValueByType(Buffer, Property[2], Item[Property[1]], Property[4] or nil)
				end
			end
		end
	end
	
	local Encoded = Buffer:ToBase91()
	return Encoded
end

function BitBufferSerialization.Deserialize(Data)
	-- make our bitbuffer and decode and stuff
	local Buffer
	
	if tostring(Data) == "BitBuffer" then
		Buffer = Data
	else
		Buffer = BitBuffer.FromBase91(Data)
	end
	
	-- read our epoch number
	local EpochNumber = Buffer:ReadUInt(10)
	local ItemNumber = Buffer:ReadUInt(32)
	
	--print("Total Item Number: ", ItemNumber)
	
	if EpochNumber ~= BitBufferSerialization.Epoch then
		error("Epoch number " .. EpochNumber .. "differs from our Epoch number " .. BitBufferSerialization.Epoch .. ". Erroring.")
	end
	
	-- make our table
	local DeserializedItems = {}
	local InstancesToSet = {} -- {Item, PropertyName, Id}
	
	for ItemId = 1, ItemNumber do
		local TypeId = Buffer:ReadUInt(12)
		
		local ItemType = Types[TypeId]
		--print(ItemType, TypeId)
		local NewInstance = Instance.new(ItemType.Name)
		for Index, Property in ipairs(ItemType.Properties) do
			if Index ~= 1 then -- skip typeid and item
				if Property[2] == "Instance" then -- handle instances manually because we do them all at the end
					if InstancesToSet[NewInstance] == nil then
						InstancesToSet[NewInstance] = {}
					end
					InstancesToSet[NewInstance][Property[1]] = getDeserializedValue(Buffer, Property)
				else
					NewInstance[Property[1]] = getDeserializedValue(Buffer, Property)
				end
			end
		end
		
		DeserializedItems[ItemId] = NewInstance
	end
	
	-- anything with a value of 0 gets added to our return table for "root" items
	local ReturnItems = {}
	local WaitIndex = 0
	
	for Item, ItemData in pairs(InstancesToSet) do
		WaitIndex += 1
		if WaitIndex % 10000 == 0 then
			task.wait(0.04)
		end
		for PropertyName, ParentId in pairs(ItemData) do
			if ParentId == 1 then
				table.insert(ReturnItems, Item)
			elseif ParentId ~= 0 then
				Item[PropertyName] = DeserializedItems[ParentId - 1]
			end
		end
	end
	
	return ReturnItems
end

-- Utility function that returns the Epoch number as an integer so code can differentiate between different versions of this
-- module.
-- Also returns the buffer so that we can use it in following functions, to prevent having to decode
-- twice.
function BitBufferSerialization.GetEpochNumberFromData(DataString)
	-- make our bitbuffer and decode and stuff
	local Buffer = BitBuffer.FromBase91(DataString)
	local BufferEpoch = Buffer:ReadUInt(10)
	
	Buffer:ResetCursor()
	
	return BufferEpoch, Buffer
end

return BitBufferSerialization
