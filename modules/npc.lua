local M = {}

local lib = require "modules.general"

local playerTint = vmath.vector4(0)
local tints = {
                vmath.vector4(0.36, 0.43, 0.88, 1), vmath.vector4(0.6, 0.9, 0.31, 1),
                vmath.vector4(0.87, 0.44, 0.15, 1), vmath.vector4(0.84, 0.48, 0.73, 1),
                vmath.vector4(0.46, 0.26, 0.54, 1), vmath.vector4(0.67, 0.2, 0.2, 1),
                vmath.vector4(0.37, 0.8, 0.89, 1), vmath.vector4(0.96, 0.95, 0.21, 1),
              }

-- tints[1] is for player tint
function M.initPlayerTint(class)
    tints[1], tints[class] = tints[class], tints[1]
    playerTint = tints[1]
end

function M.getTint(tint)
    return tints[tint]
end

function M.pressedTouch(self)
    -- Message from player
    -- Don't animate color if already animeting
    if not self.isColorAnim then
        self.isColorAnim = true
        go.animate("#sprite", "tint", go.PLAYBACK_ONCE_PINGPONG, M.getTint(self.class), go.EASING_INOUTSINE, 2, 0, function ()
            self.isColorAnim = false
        end)

        -- If touching npc
        -- Send message to all npcs in the table
        -- Can send more then once np
        if #self.collidedNpcs ~= 0 then
            local otherClasses = {}
            for index, value in ipairs(self.collidedNpcs) do
                msg.post(value, lib.hashed("pressed"))

                -- Check if touching to same color
                local url = msg.url(value)
                url.fragment = "npc"
                otherClasses[index] = go.get(url, "class")
                M.checkClasses(self, otherClasses)
            end
        end
    end
end

function M.checkClasses(self, otherClasses)
    for index, value in ipairs(otherClasses) do
        if self.class == value then
            if self.url.path == lib.hashed("/npc") or self.url.path == lib.hashed("/npc1") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(650, 0, 0), go.EASING_INCUBIC, 2, 0, function ()
                    go.animate("/arrow#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.playerTint, go.EASING_LINEAR, 0.5)

                    local posx = go.get_position("/arrow").x
                    go.animate("/arrow", "position.x", go.PLAYBACK_LOOP_PINGPONG, posx + 50, go.EASING_INEXPO, 2)

                    go.animate("/right_light#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    sprite.set_constant("/left_light2#sprite", "tint", M.getTint(self.class))

                    go.delete("/door1")
                    msg.post(".", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc2") or self.url.path == lib.hashed("/npc5") then
                    go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(1241, 131, 0), go.EASING_INCUBIC, 2, 0, function ()
                    go.delete("/door2")
                    msg.post(".", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc4") or self.url.path == lib.hashed("/npc3") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(1950, 0, 0), go.EASING_INCUBIC, 2, 0, function ()
                    go.animate("/right_light2#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    sprite.set_constant("/left_light3#sprite", "tint", M.getTint(self.class))

                    go.delete("/door3")
                    msg.post(".", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc6") or self.url.path == lib.hashed("/npc7") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(2600, -350, 0), go.EASING_INCUBIC, 2, 0, function ()
                    go.animate("/down_light3#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    sprite.set_constant("/up_light4#sprite", "tint", M.getTint(self.class))

                    go.delete("/door4")
                    msg.post(".", "disable")
                    msg.post("/npc8", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc9") or self.url.path == lib.hashed("/npc11") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(1955, -736, 0), go.EASING_INCUBIC, 2, 0, function ()
                go.animate("/right_light4#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    sprite.set_constant("/right_light5#sprite", "tint", M.getTint(self.class))

                    go.delete("/door5")
                    msg.post(".", "disable")
                    msg.post("/npc10", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc12") or self.url.path == lib.hashed("/npc13") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(659, -736, 0), go.EASING_INCUBIC, 2, 0, function ()
                go.animate("/left_light5#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    sprite.set_constant("/right_light7#sprite", "tint", M.getTint(self.class))

                    go.delete("/door6")
                    msg.post(".", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc16") or self.url.path == lib.hashed("/npc17") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(1296, -1106, 0), go.EASING_INCUBIC, 2, 0, function ()
                    msg.post(".", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc14") or self.url.path == lib.hashed("/npc15") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(1305, -1106, 0), go.EASING_INCUBIC, 2, 0, function ()
                go.animate("/down_light5#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)

                    go.delete("/door7")
                    msg.post(".", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc19") or self.url.path == lib.hashed("/npc20") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(-1935, -725, 0), go.EASING_INCUBIC, 2, 0, function ()
                go.animate("/left_light8#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    sprite.set_constant("/right_light9#sprite", "tint", M.getTint(self.class))

                    go.delete("/door9")
                    msg.post(".", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc21") or self.url.path == lib.hashed("/npc22") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(-2590, -385, 0), go.EASING_INCUBIC, 2, 0, function ()
                go.animate("/up_light9#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    sprite.set_constant("/down_light10#sprite", "tint", M.getTint(self.class))

                    go.delete("/door10")
                    msg.post(".", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc23") or self.url.path == lib.hashed("/npc24") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(-1955, 0, 0), go.EASING_INCUBIC, 2, 0, function ()
                go.animate("/right_light10#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    sprite.set_constant("/left_light11#sprite", "tint", M.getTint(self.class))

                    go.delete("/door11")
                    msg.post(".", "disable")

                    lib.once = false
                end)
            elseif self.url.path == lib.hashed("/npc25") or self.url.path == lib.hashed("/npc26") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(-658, 0, 0), go.EASING_INCUBIC, 2, 0, function ()
                go.animate("/right_light11#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    sprite.set_constant("/left_light#sprite", "tint", M.getTint(self.class))

                    go.delete("/door12")
                    msg.post(".", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc28") or self.url.path == lib.hashed("/npc29") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(0, 359, 0), go.EASING_INCUBIC, 2, 0, function ()
                go.animate("/up_light#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    sprite.set_constant("/down_light12#sprite", "tint", M.getTint(self.class))

                    go.delete("/door")
                    msg.post(".", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc30") or self.url.path == lib.hashed("/npc31") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(509, 738, 0), go.EASING_INCUBIC, 2, 0, function ()
                go.animate("/light6#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    go.delete("/mach6")
                    msg.post(".", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc32") or self.url.path == lib.hashed("/npc33") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(529, 738, 0), go.EASING_INCUBIC, 2, 0, function ()
                go.animate("/light5#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    go.delete("/mach5")
                    msg.post(".", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc34") or self.url.path == lib.hashed("/npc35") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(549, 738, 0), go.EASING_INCUBIC, 2, 0, function ()
                go.animate("/light4#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    go.delete("/mach4")
                    msg.post(".", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc36") or self.url.path == lib.hashed("/npc37") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(569, 738, 0), go.EASING_INCUBIC, 2, 0, function ()
                go.animate("/light3#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    go.delete("/mach3")
                    msg.post(".", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc38") or self.url.path == lib.hashed("/npc39") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(589, 738, 0), go.EASING_INCUBIC, 2, 0, function ()
                go.animate("/light2#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    go.delete("/mach2")
                    msg.post(".", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc40") or self.url.path == lib.hashed("/npc41") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(629, 738, 0), go.EASING_INCUBIC, 2, 0, function ()
                go.animate("/light1#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    go.delete("/mach1")
                    msg.post(".", "disable")
                end)
            elseif self.url.path == lib.hashed("/npc42") or self.url.path == lib.hashed("/npc43") then
                go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(609, 738, 0), go.EASING_INCUBIC, 2, 0, function ()
                go.animate("/light#sprite", "tint", go.PLAYBACK_ONCE_FORWARD, M.getTint(self.class), go.EASING_LINEAR, 0.5)
                    sprite.set_constant("/left_light13#sprite", "tint", M.getTint(1))

                    go.delete("/mach")
                    msg.post(".", "disable")
                end)
            end
        end
    end
end

return M