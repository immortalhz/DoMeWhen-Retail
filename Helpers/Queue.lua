local DMW = DMW
DMW.Helpers.Queue = {}
local Queue = DMW.Helpers.Queue
DMW.Tables.Bindings = {}
local QueueFrame

function Queue.GetBindings()
    table.wipe(DMW.Tables.Bindings)
    local Type, ID, Key1, Key2, BindingID
    for k, frame in pairs(ActionBarButtonEventsFrame.frames) do
        if frame.buttonType then
            Key1, Key2 = GetBindingKey(frame.buttonType .. frame:GetID())
        else
            Key1, Key2 = GetBindingKey("ACTIONBUTTON" .. frame:GetID())
        end
        Type, ID = GetActionInfo(frame.action)
        if Key1 then
            DMW.Tables.Bindings[Key1] = {["Type"] = Type, ["ID"] = ID}
        end
        if Key2 then
            DMW.Tables.Bindings[Key2] = {["Type"] = Type, ["ID"] = ID}
        end
    end
    if IsAddOnLoaded('ElvUI') then
        for i = 1, 10 do
            for k = 1, 12 do
                local Type, ID = GetActionInfo(_G["ElvUI_Bar" .. i .. "Button" .. k]._state_action)
                local Hotkey = _G["ElvUI_Bar" .. i .. "Button" .. k .. "HotKey"]:GetText()
                if ID then
                    if strsub(Hotkey, 1, 1) == 'S' and strlen(Hotkey) == 2 then
                        local Key = strsub(Hotkey, 2, 2)
                        DMW.Tables.Bindings["SHIFT-" .. Key] = {["Type"] = Type, ["ID"] = ID}
                    elseif strsub(Hotkey, 1, 1) == 'C' and strlen(Hotkey) == 2 then
                        local Key = strsub(Hotkey, 2, 2)
                        DMW.Tables.Bindings["CTRL-" .. Key] = {["Type"] = Type, ["ID"] = ID}
                    elseif strsub(Hotkey, 1, 1) == 'A' and strlen(Hotkey) == 2  then
                        local Key = strsub(Hotkey, 2, 2)
                        DMW.Tables.Bindings["ALT-" .. Key] = {["Type"] = Type, ["ID"] = ID}
                    elseif strsub(Hotkey, 1, 1) == 'M' and strlen(Hotkey) == 2 then
                        local Key = strsub(Hotkey, 2, 2)
                        DMW.Tables.Bindings["BUTTON" .. Key] = {["Type"] = Type, ["ID"] = ID}
                    elseif strsub(Hotkey, 1, 1) == 'F' and strlen(Hotkey) == 2 then
                        local Key = strsub(Hotkey, 2, 2)
                        DMW.Tables.Bindings[Hotkey] = {["Type"] = Type, ["ID"] = ID}
                    elseif strlen(Hotkey) == 1 then
                        local Key = strsub(Hotkey, 1, 1)
                        DMW.Tables.Bindings[Key] = {["Type"] = Type, ["ID"] = ID}
                    end
                end
            end
        end
    end
end

local function SpellSuccess(self, event, ...)
    if (event == "UNIT_SPELLCAST_SUCCEEDED" or event == "UNIT_SPELLCAST_START") and (Queue.Spell or Queue.Item) then
        local SourceUnit = select(1, ...)
        local SpellID = select(3, ...)
        if SourceUnit == "player" then
            if Queue.Spell and Queue.Spell.SpellName == GetSpellInfo(SpellID) then
                -- print("Queue Casted: " .. Queue.Spell.SpellName)
                Queue.Spell = false
                Queue.Target = false
            elseif Queue.Item and Queue.Item.SpellID == SpellID then
                Queue.Item = false
                Queue.Target = false
            end
        end
    end
end

local function CheckPress(self, Key)
    if DMW.Player.Combat then
        local KeyPress = ""
        if IsLeftShiftKeyDown() then
            KeyPress = "SHIFT-"
        elseif IsLeftAltKeyDown() then
            KeyPress = "ALT-"
        elseif IsLeftControlKeyDown() then
            KeyPress = "CTRL-"
        end
        KeyPress = KeyPress .. Key
        if DMW.Tables.Bindings[KeyPress] then
            local Type, ID = DMW.Tables.Bindings[KeyPress].Type, DMW.Tables.Bindings[KeyPress].ID
            if Type == "spell" then
                -- print(ID)
                local Spell = DMW.Helpers.Rotation.GetSpellByID(ID)
                -- print(Spell.Key)
                if Spell and Spell:CD() < DMW.Settings.profile.Queue.Wait then
                    local QueueSetting = DMW.Settings.profile.Queue[Spell.SpellName]
                    if QueueSetting == 2 then
                        Queue.Spell = Spell
                        Queue.Time = DMW.Time
                        Queue.Type = 2
                        if DMW.Player.Target then
                            Queue.Target = DMW.Player.Target
                        else
                            Queue.Target = DMW.Player
                        end
                    elseif QueueSetting == 3 and DMW.Player.Mouseover then
                        Queue.Spell = Spell
                        Queue.Time = DMW.Time
                        Queue.Target = DMW.Player.Mouseover
                        Queue.Type = 3
                    elseif QueueSetting == 4 then
                        Queue.Spell = Spell
                        Queue.Time = DMW.Time
                        local x, y = GetMousePosition()
                        Queue.PosX, Queue.PosY, Queue.PosZ = ScreenToWorld(x, y)
                        Queue.Type = 4
                    elseif QueueSetting == 5 then
                        Queue.Spell = Spell
                        Queue.Time = DMW.Time
                        Queue.Type = 5
                    end
                end
            elseif Type == "item" and DMW.Settings.profile.Queue.Items then
                Queue.Item = DMW.Classes.Item(ID)
                Queue.Time = DMW.Time
                if DMW.Player.Target then
                    Queue.Target = DMW.Player.Target
                else
                    Queue.Target = DMW.Player
				end
			elseif Type == "macro" then
				if ID then
					local macroSpell = GetMacroSpell(ID)
					local Spell = DMW.Helpers.Rotation.GetSpellByID(macroSpell)
					if Spell and Spell:CD() < DMW.Settings.profile.Queue.Wait then
						Queue.Spell = Spell
						Queue.Time = DMW.Time
						Queue.Type = 3
						local macroBody = GetMacroBody(ID)
						for token in string.gmatch(macroBody, "\@[a-z]+") do
							if token == "@player" then
								Queue.Target = DMW.Player
							elseif token == "@mouseover" then
								Queue.Target = DMW.Player.Mouseover
							elseif token == "@focus" then
								Queue.Target = DMW.Player.Focus
							elseif token == "@target" then
								Queue.Target = DMW.Player.Target
							elseif token == "@pet" then
								Queue.Target = DMW.Player.Pet
							end
						end
					end
				end
            end
        end
    end
end

-- local CursorCastFix = false
function Queue.Run()
    if not QueueFrame then
        QueueFrame = CreateFrame("Frame")
        QueueFrame:SetPropagateKeyboardInput(true)
        QueueFrame:SetScript("OnKeyDown", CheckPress)
        QueueFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
        QueueFrame:RegisterEvent("UNIT_SPELLCAST_START")
        QueueFrame:SetScript("OnEvent", SpellSuccess)
    end
    if GetKeyState(0x05) then
        CheckPress(nil, "BUTTON4")
    elseif GetKeyState(0x06) then
        CheckPress(nil, "BUTTON5")
    end
    if (Queue.Spell or Queue.Item) and (DMW.Time - Queue.Time) > DMW.Settings.profile.Queue.Wait then
        Queue.Spell = false
        Queue.Target = false
        Queue.Item = false
        -- CursorCastFix = false
        -- print("Clear")
    end
    if Queue.Spell and DMW.Player.Combat then
        if Queue.Type == 2 then
            if Queue.Target then--and IsSpellInRange(Queue.Spell.SpellName, Queue.Target.Pointer) ~= nil then
                if Queue.Spell:Cast(Queue.Target) then
                    print(Queue.Target.Name, Queue.Spell.SpellName)
                    return true
                end
            else
                if Queue.Spell:Cast(DMW.Player) then
                    return true
                end
			end
        elseif Queue.Type == 3 then
            if Queue.Spell:Cast(Queue.Target) then
                return true
            end
        elseif Queue.Type == 4 then
            if Queue.Spell:CastGround(Queue.PosX, Queue.PosY, Queue.PosZ) then
                return true
            end
        elseif Queue.Type == 5 then
            -- print(Queue.Spell.Key)
            if IsAoEPending() then
                if GetKeyState(0x02) then
                    print("clear")
                    Queue.Spell = false
                    Queue.Target = false
                    Queue.Item = false
                end
                return true
            end
            if Queue.Spell:IsReady() and not IsAoEPending() then
                CastSpellByName(Queue.Spell.SpellName)
                return true
            end
        end
    elseif Queue.Item and DMW.Player.Combat then
        Queue.Item:Use(Queue.Target)
    end
end
