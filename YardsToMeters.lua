local function replaceYardsWithMeters(text)
    if not text then return end
    -- Replace " yd" with " meters"
    return text:gsub("(%d+) yd", function(yards)
        local meters = tonumber(yards) * 0.9144
        return string.format("%.1f meters", meters)
    end)
end

local function modifyTooltip(self)
    print("Tooltip modification function called")

    local spellID = select(2, self:GetSpell())
    if not spellID then
        print("No spell ID found")
        return
    end

    local spellName, _, _, _, minRange, maxRange = GetSpellInfo(spellID)
    -- Loop through all tooltip lines and print them out
    for i = 1, self:NumLines() do
        local leftLine = _G[self:GetName() .. "TextLeft" .. i]
        local rightLine = _G[self:GetName() .. "TextRight" .. i]
        if leftLine and leftLine:GetText() then
            local leftLineText = leftLine:GetText()
        end
        if rightLine and rightLine:GetText() then
            local rightLineText = rightLine:GetText()

            -- Check if the right line contains " yd"
            if rightLineText:find("(%d+) yd") then
                local updatedText = replaceYardsWithMeters(rightLineText)
                rightLine:SetText(updatedText)
            end
        end
    end
    self:Show()
end

-- Hook into GameTooltip for various tooltip events
GameTooltip:HookScript("OnTooltipSetSpell", modifyTooltip)