local addonName = ...

local raidMarker = (GetLocale() == "ruRU") and "{звезда}" or "{rt1}"
local questiePrefix = raidMarker .. " Questie : "

local function FilterQuestieAnnounce(self, event, msg, author, ...)
    -- Check if the message is a valid string and contains the Questie prefix
    if type(msg) == "string" and msg:find(questiePrefix, 1, true) then
        return true
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", FilterQuestieAnnounce)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", FilterQuestieAnnounce)

        print("|cff00ff00[Questie ShutUp!]|r Loaded.")
        self:UnregisterEvent("PLAYER_LOGIN")
    end
end)
