local megaserver = LibGuildHistoryCache.megaserver

function LibGuildHistoryCache:GetGuildInfo()
  LibGuildHistoryCache.numberOfGuilds = GetNumGuilds()

  for i = 1, LibGuildHistoryCache.numberOfGuilds do
    LibGuildHistoryCache.guildInfo[i].guildID = GetGuildId(i)
    LibGuildHistoryCache.guildInfo[i].guildName = GetGuildName(LibGuildHistoryCache.guildInfo[i].guildID)
  end
end

--- Returns a guild events unique id
function LibGuildHistoryCache:getGuildEventId(guildToScan, category, eventIndex)
    local eventId = GetGuildEventId(guildToScan, category, eventIndex)
    return tonumber(Id64ToString(eventId))
end

function LibGuildHistoryCache:ProcessGuildHistoryResponse(eventCode, guildID, category)
  local guildName = GetGuildName(guildID)
  local numEvents = GetNumGuildEvents(guildID, GUILD_HISTORY_STORE)
  local theEvent = {}
  local eventsAdded = 0
  LibGuildHistoryCache.dm("Debug", string.format('ProcessGuildHistoryResponse: %s (%s)', guildName, numEvents))
  for i = 1, numEvents do
    theEvent[i] = { GetGuildEventInfo(guildID, GUILD_HISTORY_STORE, i) }
    --LibGuildHistoryCache.dm("Debug", theEvent[i])
  end
end
--- Handle Guild History Evert
local function OnGuildHistoryEvent(eventCode, guildID, category)
    if (eventCode ~= EVENT_GUILD_HISTORY_RESPONSE_RECEIVED) then
        return
    end
   LibGuildHistoryCache.dm("Debug", "OnGuildHistoryEvent")
   LibGuildHistoryCache.dm("Debug", string.format("event code: %s guild ID: %s category: %s", eventCode, GetGuildName(guildID), LibGuildHistoryCache.categoryText[category]))
   LibGuildHistoryCache:ProcessGuildHistoryResponse(eventCode, guildID, category)
end
EVENT_MANAGER:RegisterForEvent(LibGuildHistoryCache.name, EVENT_GUILD_HISTORY_RESPONSE_RECEIVED, OnGuildHistoryEvent)

--- Handle Guild History Evert
local function OnGuildHistoryCategoryUpdated(eventCode, guildID, category)
    if (eventCode ~= EVENT_GUILD_HISTORY_CATEGORY_UPDATED) then
        return
    end
end
EVENT_MANAGER:RegisterForEvent(LibGuildHistoryCache.name, EVENT_GUILD_HISTORY_CATEGORY_UPDATED, OnGuildHistoryCategoryUpdated)

function LibGuildHistoryCache:requestPage(guildToScan, category, eventIndex)
    local eventId = GetGuildEventId(guildToScan, category, eventIndex)
    return tonumber(Id64ToString(eventId))
end

ZO_PreHook("RequestMoreGuildHistoryCategoryEvents", function()
  LibGuildHistoryCache.dm("Debug", "RequestMoreGuildHistoryCategoryEvents was called")
end)

local function OnAddOnLoaded(eventCode, addOnName)
   if addOnName ~= LibGuildHistoryCache.name then return end
   LibGuildHistoryCache.dm("Debug", "LibGuildHistoryCache Loaded")
   -- setup guild names and get guild IDs first
   LibGuildHistoryCache:GetGuildInfo()
end
EVENT_MANAGER:RegisterForEvent(LibGuildHistoryCache.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
