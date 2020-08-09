local megaserver = LibGuildHistoryCache.megaserver
LibGuildHistoryCache_SavedVariables = LibGuildHistoryCache_SavedVariables or {}

function LibGuildHistoryCache:GetGuildInfo()
  LibGuildHistoryCache.numberOfGuilds = GetNumGuilds()

  for i = 1, LibGuildHistoryCache.numberOfGuilds do
    LibGuildHistoryCache.guildInfo[i].guildID = GetGuildId(i)
    LibGuildHistoryCache.guildInfo[i].guildName = GetGuildName(LibGuildHistoryCache.guildInfo[i].guildID)
  end
end

--- Returns a guild events unique id
function LibGuildHistoryCache:BuildSavedVarsTable(theEvent)
    local e = {}
    e.eventType = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_EVENT_TYPE] 
    e.secsSince = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_SECONDS_SINCE_EVENT] 
    e.seller = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_SELLER] 
    e.buyer = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_BUYER] 
    e.quantity = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_QTY_SOLD] 
    e.itemName = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_ITEM_LINK] 
    e.salePrice = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_PRICE] 
    e.taxes = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_TAXES] 
    return e
end

--[[ 
returns true is the infromation is the same, skips 
secsSince because that will be different then the 
saved vars data
]]--
function compare(theEvent, cachedEvent)
  local duplicateInfo = false
  for k,v in pairs(theEvent) do
    if k ~= "secsSince" then
      if v == cachedEvent[k] then
        --LibGuildHistoryCache.dm("Debug", string.format('Key: %s', k))
        --LibGuildHistoryCache.dm("Debug", string.format('Values: %s : %s', v, cachedEvent[k]))
        duplicateInfo = true
      end
    end
  end
  return duplicateInfo
end

function LibGuildHistoryCache:ProcessGuildHistoryResponse(eventCode, guildID, category, eventTriggered)
  local guildName = GetGuildName(guildID)
  local numEvents = GetNumGuildEvents(guildID, GUILD_HISTORY_STORE)
  local theEvent = {}
  local eventsAdded = 0
  local duplicateEvents = 0
  LibGuildHistoryCache.dm("Debug", string.format('ProcessGuildHistoryResponse: %s (%s) from event: %s', guildName, numEvents, eventTriggered))
  for i = 1, numEvents do
    local theEvent = { GetGuildEventInfo(guildID, GUILD_HISTORY_STORE, i) }
    local index = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_EVENTID]
    if LibGuildHistoryCache_SavedVariables[index] == nil then 
      eventsAdded = eventsAdded + 1
      LibGuildHistoryCache_SavedVariables[index] = {}
      LibGuildHistoryCache_SavedVariables[index] = LibGuildHistoryCache:BuildSavedVarsTable(theEvent)
    else
      duplicateEvents = duplicateEvents + 1
    end
  end
  LibGuildHistoryCache.dm("Debug", string.format("%s Processed (%s) events: New Sales (%s): Duplicate Sales (%s)", guildName, numEvents, eventsAdded, duplicateEvents))
end

--- Handle Guild History Evert
local function OnGuildHistoryEvent(eventCode, guildID, category)
    if (eventCode ~= EVENT_GUILD_HISTORY_RESPONSE_RECEIVED) then
        return
    end
   --LibGuildHistoryCache.dm("Debug", "OnGuildHistoryEvent")
   --LibGuildHistoryCache.dm("Debug", string.format("event code: %s guild ID: %s category: %s", eventCode, GetGuildName(guildID), LibGuildHistoryCache.categoryText[category]))
   LibGuildHistoryCache:ProcessGuildHistoryResponse(eventCode, guildID, category, "Guild History Received")
end
EVENT_MANAGER:RegisterForEvent(LibGuildHistoryCache.name, EVENT_GUILD_HISTORY_RESPONSE_RECEIVED, OnGuildHistoryEvent)

function LibGuildHistoryCache:RequestPage(guildToScan, category, eventIndex)
end

--[[
This is called when I am on the history tab and I press E.
No other events fire that I am watching though.
]]--
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
