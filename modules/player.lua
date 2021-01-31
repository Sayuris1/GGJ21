local M = {}

local lib = require "modules.general"
local npc = require "modules.npc"

M.canDash = false
M.canZone = false

function M.fallowBalls(enable, lvl)
    if lvl == 7 then
        if enable then
            msg.post("/npcFallow", "enable")
            msg.post("/npcFallow1", "enable")
            msg.post("/npcFallow2", "enable")
            msg.post("/npcFallow3", "enable")
            msg.post("/npcFallow4", "enable")
            msg.post("/npcFallow5", "enable")
        else
            msg.post("/npcFallow", "disable")
            msg.post("/npcFallow1", "disable")
            msg.post("/npcFallow2", "disable")
            msg.post("/npcFallow3", "disable")
            msg.post("/npcFallow4", "disable")
            msg.post("/npcFallow5", "disable")
        end
    elseif lvl == 9 then
        if enable then
            msg.post("/npcFallow7", "enable")
        else
            msg.post("/npcFallow7", "disable")
        end
    elseif lvl == 10 and lib.once then
        if enable then
            msg.post("/npc24", "enable")
        else
            msg.post("/npc24", "disable")
        end
    elseif lvl == 11 then
        if enable then
            msg.post("/npc25", "enable")
            msg.post("/npc26", "enable")
            msg.post("/npc27", "enable")
        else
            msg.post("/npc25", "disable")
            msg.post("/npc26", "disable")
            msg.post("/npc27", "disable")
        end
    end
end

function M.pressedTouch(self)
    -- Space and Lclick
    -- Don't animate color if already animeting
    if not self.isColorAnim then
        -- End game
        if self.collidedNpcs[1] == lib.hashed("/npc44") then
            msg.post(".", "release_input_focus")
            msg.post(lib.zoneUrl.path, "release_input_focus")
            go.animate(lib.zoneUrl.path, "scale", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(999), go.EASING_LINEAR, 80)

            go.animate("#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, npc.playerTint, go.EASING_INOUTSINE, 2)
            go.animate("/npc44#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, npc.playerTint, go.EASING_INOUTSINE, 2)
            
            go.animate("text1", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(1072, 952, 10), go.EASING_OUTBOUNCE, 2)
            go.animate("text2", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(1356, 948, 10), go.EASING_OUTBOUNCE, 2.5)
            go.animate("text3", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(1585, 951, 10), go.EASING_OUTBOUNCE, 3)
            go.animate("text4", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(1362, 848, 10), go.EASING_OUTBOUNCE, 3.5)
            go.animate("text5", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(1362, 771, 10), go.EASING_OUTBOUNCE, 4)

            return
        end

        -- Change sprite tint to white first
        sprite.set_constant("/player#sprite", "tint", vmath.vector4(1))

        self.isColorAnim = true
        go.animate("#sprite", "tint", go.PLAYBACK_ONCE_PINGPONG, npc.playerTint, go.EASING_INOUTSINE, 2, 0, function ()
            self.isColorAnim = false
        end)

        -- If touching npc
        -- Send message to all npcs in the table
        -- Can send more then once np
        if #self.collidedNpcs ~= 0 then
            local otherClasses = {}
            for index, value in ipairs(self.collidedNpcs) do
                if value ~= lib.zoneUrl.path then
                    msg.post(value, lib.hashed("pressed"))

                    local url = msg.url(value)
                    url.fragment = "npc"
                    otherClasses[index] = go.get(url, "class")
                end
            end
        end
    end
end

function M.checkClasses(self, otherClasses)
    for index, value in ipairs(otherClasses) do
        if 0 == value then
            print("PLAYER FOUND SAME")
        end
    end
end

return M