local M = {}

local camera = require "orthographic.camera"

M.hashedTable = {}

------------------ PROJECT GLOBALS ----------------------------------------
M.once = true
M.zoneUrl = msg.url()
------------------ PROJECT GLOBALS ----------------------------------------

-- Adds to hashedTable, if already hashed simply return
-- string --> string to hash
function M.hashed ( string )
	if M.hashedTable[string] == nil then
		M.hashedTable[string] = hash(string)
	end
	return M.hashedTable[string]
end

function M.CursorUpdate(action, action_id)
	-- Send worldPos to cursor
	local cursorScreen = vmath.vector3(action.x, action.y, 0)
	local cursorWorld = camera.screen_to_world(M.hashed("/camera"), cursorScreen)

	action.x = cursorWorld.x
	action.y = cursorWorld.y

	msg.post("/cursor#cursor", "input", { action_id = action_id, action = action })
end

function M.Find(table, value)
	for i,v in ipairs(table) do
		if v == value then
			return i
		end
	end
	print("Error: Cant Find Value. general.lua -> M.Find")
end

function M.Shift(table, input, isIndex)
	local index
	if isIndex then
		index = input
	else
		index = M.Find(table, input)
	end

	for i = index, #table do
		table[i] = table[i + 1]
	end
end

function M.LookAt (selfPos, lookPos, selfId)
	local angle = math.atan2(selfPos.x - lookPos.x , lookPos.y - selfPos.y)
	go.set_rotation(vmath.quat_rotation_z(angle), selfId)
end

function M.ScaleTo(selfPos, lookPos, size)
	local distance = vmath.vector3(1, vmath.length(lookPos - selfPos) / size, 1)
	go.set_scale(distance)
end

function M.Fallow(selfPos, otherPos, speed)
	local distance = selfPos - otherPos
	local normal = -vmath.normalize(distance)
	local speed = vmath.vector3(speed, speed, 1)

	msg.post("#collisionobject", "apply_force", {force = vmath.mul_per_elem(normal, speed), position = selfPos})
end

function M.Round(x)
  return x >= 0 and math.floor( x + 0.5) or math.ceil( x- 0.5)
end

return M