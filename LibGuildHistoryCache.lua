function LibGuildHistoryCache:GetGuildInfo()
  LibGuildHistoryCache.numberOfGuilds = GetNumGuilds()

  for i = 1, LibGuildHistoryCache.numberOfGuilds do
    LibGuildHistoryCache.guildInfo[i].guildID = GetGuildId(i)
    LibGuildHistoryCache.guildInfo[i].guildName = GetGuildName(LibGuildHistoryCache.guildInfo[i].guildID)
  end
end

function LibGuildHistoryCache.NonContiguousNonNilCount(tableObject)
  local count = 0

  for _, v in pairs(tableObject)
  do
      if v ~= nil then count = count + 1 end
  end

  return count
end

--- Returns a guild events unique id
function LibGuildHistoryCache:BuildSavedVarsTable(theEvent, category)
    local e = {}
    -- general
    if category == 1 then
      e.eventType = theEvent[LibGuildHistoryCache.generalTableEnum.GENERAL_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.generalTableEnum.GENERAL_HISTORY_SECONDS_SINCE_EVENT]
      e.guildMember = theEvent[LibGuildHistoryCache.generalTableEnum.GENERAL_HISTORY_GUILD_MEMBER]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.generalTableEnum.GENERAL_HISTORY_SECONDS_SINCE_EVENT]
    end
    -- bank
    if category == 2 then
      e.eventType = theEvent[LibGuildHistoryCache.bankTableEnum.BANK_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.bankTableEnum.BANK_HISTORY_SECONDS_SINCE_EVENT]
      e.guildMember = theEvent[LibGuildHistoryCache.bankTableEnum.BANK_HISTORY_GUILD_MEMBER]
      e.quantity = theEvent[LibGuildHistoryCache.bankTableEnum.BANK_HISTORY_QTY]
      e.itemLink = theEvent[LibGuildHistoryCache.bankTableEnum.BANK_HISTORY_ITEM_LINK]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.bankTableEnum.BANK_HISTORY_SECONDS_SINCE_EVENT]
    end
    -- guild store
    if category == 3 then
      e.eventType = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_SECONDS_SINCE_EVENT]
      e.seller = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_SELLER]
      e.buyer = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_BUYER]
      e.quantity = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_QTY_SOLD]
      e.itemLink = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_ITEM_LINK]
      e.salePrice = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_PRICE]
      e.taxes = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_TAXES]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_SECONDS_SINCE_EVENT]
    end
    -- combat store, leave it so I can decode the table
    if category == 4 then
      e.eventType = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_SECONDS_SINCE_EVENT]
      e.seller = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_SELLER]
      e.buyer = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_BUYER]
      e.quantity = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_QTY_SOLD]
      e.itemLink = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_ITEM_LINK]
      e.salePrice = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_PRICE]
      e.taxes = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_TAXES]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_SECONDS_SINCE_EVENT]
    end
    -- alliance war
    if category == 5 then
      e.eventType = theEvent[LibGuildHistoryCache.avaTableEnum.AVA_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.avaTableEnum.AVA_HISTORY_SECONDS_SINCE_EVENT]
      if LibGuildHistoryCache.NonContiguousNonNilCount(theEvent) == 6 then
        e.guildMember = theEvent[LibGuildHistoryCache.avaTableEnum.AVA_HISTORY_GUILD_MEMBER]
        e.location = theEvent[LibGuildHistoryCache.avaTableEnum.AVA_HISTORY_LOCATION_M]
        e.campaign = theEvent[LibGuildHistoryCache.avaTableEnum.AVA_HISTORY_CAMPAIGN_M]
      else
        e.location = theEvent[LibGuildHistoryCache.avaTableEnum.AVA_HISTORY_LOCATION_NM]
        e.campaign = theEvent[LibGuildHistoryCache.avaTableEnum.AVA_HISTORY_CAMPAIGN_NM]
      end
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.avaTableEnum.AVA_HISTORY_SECONDS_SINCE_EVENT]
    end
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
    if k ~= "secsSince" or k ~= "timestamp" then
      if v == cachedEvent[k] then
        --LibGuildHistoryCache.dm("Debug", string.format('Key: %s', k))
        --LibGuildHistoryCache.dm("Debug", string.format('Values: %s : %s', v, cachedEvent[k]))
        duplicateInfo = true
      end
    end
  end
  return duplicateInfo
end

function LibGuildHistoryCache:ProcessGuildHistoryResponse(eventCode, guildID, category)
  local megaserver = LibGuildHistoryCache.MegaserverGuildIDIndex(guildID, category)
  local guildName = GetGuildName(guildID)
  local numEvents = GetNumGuildEvents(guildID, category)
  local theEvent = {}
  local eventsAdded = 0
  local duplicateEvents = 0
  local extra = false
  -- GUILD_HISTORY_STORE
  LibGuildHistoryCache.dm("Debug", string.format('Process Guild History Response for: %s (%s) from category: %s', guildName, numEvents, LibGuildHistoryCache.categoryText[category]))
  for i = 1, numEvents do
    local theEvent = { GetGuildEventInfo(guildID, category, i) }
    if category == 1 and i == 1 and extra then
      LibGuildHistoryCache.dm("Debug", "category 4")
      LibGuildHistoryCache.dm("Debug", theEvent)
    end
    if category == 2 and i == 1 and extra then
      LibGuildHistoryCache.dm("Debug", "category 4")
      LibGuildHistoryCache.dm("Debug", theEvent)
    end
    if category == 4 and i == 1 and extra then
      LibGuildHistoryCache.dm("Debug", "category 4")
      LibGuildHistoryCache.dm("Debug", theEvent)
    end
    if category == 5 and i == 1 and extra then
      LibGuildHistoryCache.dm("Debug", "category 5")
      LibGuildHistoryCache.dm("Debug", theEvent)
    end
    local index = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_EVENTID]
    local timeSinceInSeconds = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_SECONDS_SINCE_EVENT]

    if i == 1 then LibGuildHistoryCache.newestEvent = GetTimeStamp() - theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_SECONDS_SINCE_EVENT] end
    if i == numEvents then LibGuildHistoryCache.oldestEvent = GetTimeStamp() - theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_SECONDS_SINCE_EVENT] end

    --[[ timeSinceInSeconds < LibGuildHistoryCache.oneYearInSeconds to
    prevent adding an event with an erroneous ammount of time in seconds
    since the sale was made.
    ]]--
    if LibGuildHistoryCache_SavedVariables[megaserver][index] == nil and timeSinceInSeconds < LibGuildHistoryCache.oneYearInSeconds then
      eventsAdded = eventsAdded + 1
      LibGuildHistoryCache_SavedVariables[megaserver][index] = {}
      LibGuildHistoryCache_SavedVariables[megaserver][index] = LibGuildHistoryCache:BuildSavedVarsTable(theEvent, category)
    else
      duplicateEvents = duplicateEvents + 1
    end
  end
  LibGuildHistoryCache.dm("Debug", string.format("%s Processed (%s) events: New Events (%s): Duplicate Events (%s)", guildName, numEvents, eventsAdded, duplicateEvents))

  local totalRecordsInGuild = LibGuildHistoryCache.NonContiguousNonNilCount(LibGuildHistoryCache_SavedVariables[megaserver])

  LibGuildHistoryCache.dm("Debug", string.format("Total %s Events for %s [%s] : (%s)", LibGuildHistoryCache.categoryText[category], guildName, guildID, totalRecordsInGuild))
end

--- Handle Guild History Evert
local function OnGuildHistoryEvent(eventCode, guildID, category)
    if (eventCode ~= EVENT_GUILD_HISTORY_RESPONSE_RECEIVED) then
        return
    end
   --LibGuildHistoryCache.dm("Debug", "OnGuildHistoryEvent")
   --LibGuildHistoryCache.dm("Debug", string.format("event code: %s guild ID: %s category: %s", eventCode, GetGuildName(guildID), LibGuildHistoryCache.categoryText[category]))
   LibGuildHistoryCache:ProcessGuildHistoryResponse(eventCode, guildID, category)
end
EVENT_MANAGER:RegisterForEvent(LibGuildHistoryCache.name, EVENT_GUILD_HISTORY_RESPONSE_RECEIVED, OnGuildHistoryEvent)

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
   if LibGuildHistoryCache_SavedVariables.version ~= 4 then
    LibGuildHistoryCache_SavedVariables = {}
    LibGuildHistoryCache_SavedVariables.version = 4
   end
end
EVENT_MANAGER:RegisterForEvent(LibGuildHistoryCache.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
