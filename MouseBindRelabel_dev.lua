local buttonPrefixes = {
    "ActionButton",                 -- Main Bar
    "BonusActionButton",            -- Dynamic bar for Druid Forms, Warrior Stances, Rogue Stealth
    "MultiBarBottomLeftButton",     -- Bottom Left Bar
    "MultiBarBottomRightButton",    -- Bottom Right Bar
    "MultiBarRightButton",          -- Right Bar
    "MultiBarLeftButton",           -- Right Bar 2 (to the left of "Right Bar")
    "PetActionButton",              -- Pet Bar
    "ShapeshiftButton",             -- Shapeshift Bar
    "ExtraActionButton"             -- Extra Action Button
}

local function RelabelKeyBinding(button)
    if not button.HotKey then
        return
    end

    local hotkey = button.HotKey:GetText()

    if hotkey then
        for searchPattern, replacement in pairs(KeyBindingReplacements) do
            hotkey = hotkey:gsub(searchPattern, replacement)
        end

        button.HotKey:SetText(hotkey)
    end
end

local function UpdateAllActionButtons()
    for _, prefix in ipairs(buttonPrefixes) do
        for i = 1, 12 do
            local button = _G[prefix .. i]
            if button then
                RelabelKeyBinding(button)
            end
        end
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("UPDATE_BINDINGS")
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" or event == "UPDATE_BINDINGS" then
        UpdateAllActionButtons()
    end
end)
