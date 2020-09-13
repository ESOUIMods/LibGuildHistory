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
function LibGuildHistoryCache:BuildSavedVarsTable(theEvent, eventType)
    local e = {}
    if eventType == GUILD_EVENT_GUILD_INVITE then -- 1 (eventType, displayName1, displayName2)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName1 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.displayName2 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM2]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_PROMOTE then -- 3 (eventType, displayName1, displayName2, rankName)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName1 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.displayName2 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM2]
      e.rankName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM3]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_DEMOTE then -- 4 (eventType, displayName1, displayName2, rankName)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName1 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.displayName2 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM2]
      e.rankName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM3]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_CREATE then -- 5 (eventType, displayName)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_JOIN then -- 7 (eventType, joinerDisplayName, optionalInviterDisplayName)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.joinerDisplayName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.optionalInviterDisplayName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM2]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_LEAVE then -- 8 (eventType, displayName)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_KICKED then -- 12 (eventType, displayName1, displayName2)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName1 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.displayName2 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM2]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_BANKITEM_ADDED then -- 13 (eventType, displayName, itemQuantity, itemName)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.itemQuantity = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM2]
      e.itemName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM3]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_BANKITEM_REMOVED then -- 14 (eventType, displayName, itemQuantity, itemName)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.itemQuantity = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM2]
      e.itemName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM3]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_ITEM_SOLD then -- 15 (eventType, seller, buyer, quantity, itemLink, salePrice, taxes)
      e.eventType = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_SECONDS_SINCE_EVENT]
      e.seller = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_SELLER]
      e.buyer = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_BUYER]
      e.quantity = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_QTY_SOLD]
      e.itemLink = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_ITEM_LINK]
      e.salePrice = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_PRICE]
      e.taxes = theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_TAXES]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_KEEP_CLAIMED then -- 16 (eventType, displayName, keepName, campaignName)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.keepName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM2]
      e.campaignName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM3]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_KEEP_RELEASED then -- 19 (eventType, displayName, keepName, campaignName)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.keepName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM2]
      e.campaignName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM3]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_KEEP_LOST then -- 17 (eventType, keepName, campaignName)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.keepName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.campaignName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM2]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_MOTD_EDITED then -- 31 (eventType, displayName)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_BANKGOLD_GUILD_STORE_TAX then -- 29 (eventType)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_STORE_UNLOCKED then -- 33 (eventType)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_STORE_LOCKED then -- 34 (eventType)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_BANK_UNLOCKED then -- 35 (eventType)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_BANK_LOCKED then -- 36 (eventType)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_STANDARD_UNLOCKED then -- 37 (eventType)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_STANDARD_LOCKED then -- 38 (eventType)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_TABARD_UNLOCKED then -- 39 (eventType)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_TABARD_LOCKED then -- 40 (eventType)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_KIOSK_UNLOCKED then -- 42 (eventType)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_KIOSK_LOCKED then -- 43 (eventType)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_APPLICATION_DECLINED then -- 44 (eventType, displayName1, displayName2)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName1 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.displayName2 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM2]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_APPLICATION_ACCEPTED then -- 45 (eventType, displayName1, displayName2)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName1 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.displayName2 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM2]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_ADDED_TO_BLACKLIST then -- 46 (eventType, displayName1, displayName2)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName1 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.displayName2 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM2]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_REMOVED_FROM_BLACKLIST then -- 47 (eventType, displayName1, displayName2)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName1 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.displayName2 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM2]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_RECRUITMENT_GUILD_LISTED then -- 50 (eventType, displayName)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    elseif eventType == GUILD_EVENT_GUILD_RECRUITMENT_GUILD_UNLISTED then -- 51 (eventType, displayName)
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.displayName = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
    else
      LibGuildHistoryCache.dm("Debug", string.format('eventType: %s : undefined', eventType))
      e.eventType = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE]
      e.secsSince = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
      e.param1 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM1]
      e.param1 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM2]
      e.param1 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM3]
      e.param1 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM4]
      e.param1 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM5]
      e.param1 = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_PARAM6]
      e.timestamp = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]
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
  -- GUILD_HISTORY_STORE
  LibGuildHistoryCache.dm("Debug", string.format('Process Guild History Response for: %s (%s) from category: %s', guildName, numEvents, LibGuildHistoryCache.categoryText[category]))
  for i = 1, numEvents do
    local theEvent = { GetGuildEventInfo(guildID, category, i) }
    local index = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENTID]
    local timeSinceInSeconds = theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT]

    if i == 1 then LibGuildHistoryCache.newestEvent = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT] end
    if i == numEvents then LibGuildHistoryCache.oldestEvent = GetTimeStamp() - theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_SECONDS_SINCE_EVENT] end

    --[[ timeSinceInSeconds < LibGuildHistoryCache.oneYearInSeconds to
    prevent adding an event with an erroneous ammount of time in seconds
    since the sale was made.
    ]]--
    if LibGuildHistoryCache_SavedVariables[megaserver][index] == nil and timeSinceInSeconds < LibGuildHistoryCache.oneYearInSeconds then
      eventsAdded = eventsAdded + 1
      LibGuildHistoryCache_SavedVariables[megaserver][index] = {}
      LibGuildHistoryCache_SavedVariables[megaserver][index] = LibGuildHistoryCache:BuildSavedVarsTable(theEvent, theEvent[LibGuildHistoryCache.genericTableEnum.GENERIC_HISTORY_EVENT_TYPE])
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
ZO_PreHook("RequestMoreGuildHistoryCategoryEvents", function()
  LibGuildHistoryCache.dm("Debug", "RequestMoreGuildHistoryCategoryEvents was called")
end)
]]--

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
