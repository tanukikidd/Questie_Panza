local questiePatterns = {
    "^%{rt1%}%s*Questie%s*:",
    "^%{star%}%s*Questie%s*:",
    "^Questie%s*:",
    "^%[Questie%]",
    "Questie%s*:%s*.*|Hquest:",
    "^%{rt1%}%s*|c%x+|Hquest:.-|h%[.-%]|h|r%s*complet",
    "^%{rt1%}%s*%[.-%]%s*complet"
}

local function FilterQuestieAnnounce(self, event, msg, author, ...)
    local cleanMsg = string.gsub(msg, "^%s+", "")

    for _, pattern in ipairs(questiePatterns) do
        if string.find(cleanMsg, pattern) then
            return true
        end
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
