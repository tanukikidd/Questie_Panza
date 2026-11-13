local questiePatterns = {
    "^%{rt1%}%s*Questie%s*:",
    "^%{star%}%s*Questie%s*:",
	"^%{rt1%}%s*Polestar%s*:",
    "^%{star%}%s*Polestar%s*:",
    "UI%-RaidTargetingIcon_1.-Questie%s*:",
    "^Questie%s*:",
    "^%[Questie%]",
    "Questie%s*:%s*.*|Hquest:",
    "Questie%s*:%s*%[.-%]",
    "^%{rt1%}%s*|c%x+|Hquest:.-|h%[.-%]|h|r%s*complet",
    "^%{rt1%}%s*%[.-%]%s*complet",
    "UI%-RaidTargetingIcon_1.-%[.-%]%s*complet"
}

local function IsQuestieMessage(msg)
    if not msg then return false end
    local cleanMsg = string.gsub(msg, "^%s+", "")
    for _, pattern in ipairs(questiePatterns) do
        if string.find(cleanMsg, pattern) then
            return true
        end
    end
    return false
end

local function FilterQuestieAnnounce(self, event, msg, author, ...)
    if IsQuestieMessage(msg) then
        return true
    end
    return false, msg, author, ...
end

local chatEvents = {
    "CHAT_MSG_PARTY",
    "CHAT_MSG_PARTY_LEADER",
    "CHAT_MSG_RAID",
    "CHAT_MSG_RAID_LEADER",
    "CHAT_MSG_GUILD",
    "CHAT_MSG_OFFICER",
    "CHAT_MSG_SAY",
    "CHAT_MSG_YELL",
    "CHAT_MSG_WHISPER",
    "CHAT_MSG_BATTLEGROUND",
    "CHAT_MSG_BATTLEGROUND_LEADER",
    "CHAT_MSG_CHANNEL",
    "CHAT_MSG_EMOTE"
}

for _, event in ipairs(chatEvents) do
    ChatFrame_AddMessageEventFilter(event, FilterQuestieAnnounce)
end

local bubbleTimer = 0
local savedBubbles = nil
local savedPartyBubbles = nil

local function TempHideBubbles()
    if bubbleTimer <= 0 then
        savedBubbles = GetCVar("chatBubbles")
        savedPartyBubbles = GetCVar("chatBubblesParty")
    end
    SetCVar("chatBubbles", "0")
    SetCVar("chatBubblesParty", "0")
    bubbleTimer = 0.5
end

local bubbleToggleFrame = CreateFrame("Frame")
bubbleToggleFrame:RegisterEvent("CHAT_MSG_PARTY")
bubbleToggleFrame:RegisterEvent("CHAT_MSG_PARTY_LEADER")
bubbleToggleFrame:RegisterEvent("CHAT_MSG_SAY")
bubbleToggleFrame:RegisterEvent("CHAT_MSG_YELL")

bubbleToggleFrame:SetScript("OnEvent", function(self, event, msg)
    if IsQuestieMessage(msg) then
        TempHideBubbles()
    end
end)

bubbleToggleFrame:SetScript("OnUpdate", function(self, elapsed)
    if bubbleTimer > 0 then
        bubbleTimer = bubbleTimer - elapsed
        if bubbleTimer <= 0 then
            if savedBubbles then
                SetCVar("chatBubbles", savedBubbles)
                savedBubbles = nil
            end
            if savedPartyBubbles then
                SetCVar("chatBubblesParty", savedPartyBubbles)
                savedPartyBubbles = nil
            end
        end
    end
end)
