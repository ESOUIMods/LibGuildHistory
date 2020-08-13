LibGuildHistoryCache = {}
LibGuildHistoryCache.name = 'LibGuildHistoryCache'
LibGuildHistoryCache.version = '1.0'
LibGuildHistoryCache.clientLang = GetCVar("language.2")
LibGuildHistoryCache.megaserver = GetWorldName()
LibGuildHistoryCache.isScanning = false
LibGuildHistoryCache.isScanningParallel = {}
LibGuildHistoryCache.guildHistory = {}
LibGuildHistoryCache.numberOfGuilds = 0
LibGuildHistoryCache.oneHour = 3600
LibGuildHistoryCache.oneDayInSeconds = 86400
LibGuildHistoryCache_SavedVariables = LibGuildHistoryCache_SavedVariables or {}
LibGuildHistoryCache.newestEvent = 0
LibGuildHistoryCache.oldestEvent = 0
--[[
used to temporarily ignore sales that are so new
the ammount of time in seconds causes the UI to say
the sale was made 1657 months ago or 71582789 minutes ago.
]]--
LibGuildHistoryCache.oneYearInSeconds = LibGuildHistoryCache.oneDayInSeconds * 365
LibGuildHistoryCache.guildInfo = {
  [1] = { guildID = 0, guildName = 0, },
  [2] = { guildID = 0, guildName = 0, },
  [3] = { guildID = 0, guildName = 0, },
  [4] = { guildID = 0, guildName = 0, },
  [5] = { guildID = 0, guildName = 0, },
}
LibGuildHistoryCache.data = {
 [LibGuildHistoryCache.megaserver] = {},
}
LibGuildHistoryCache.categoryEnum = {
  GUILD_HISTORY_GENERAL = 1,
  GUILD_HISTORY_BANK = 2,
  GUILD_HISTORY_STORE = 3,
  GUILD_HISTORY_COMBAT = 4,
  GUILD_HISTORY_ALLIANCE_WAR = 5,
}

LibGuildHistoryCache.categoryText = {
  [LibGuildHistoryCache.categoryEnum.GUILD_HISTORY_GENERAL] = "General",
  [LibGuildHistoryCache.categoryEnum.GUILD_HISTORY_BANK] = "Bank",
  [LibGuildHistoryCache.categoryEnum.GUILD_HISTORY_STORE] = "Store",
  [LibGuildHistoryCache.categoryEnum.GUILD_HISTORY_COMBAT] = "Combat",
  [LibGuildHistoryCache.categoryEnum.GUILD_HISTORY_ALLIANCE_WAR] = "Alliance War",
}

-- alliance war
LibGuildHistoryCache.avaTableEnum = {
  AVA_HISTORY_EVENT_TYPE = 1,
  AVA_HISTORY_SECONDS_SINCE_EVENT = 2,
  AVA_HISTORY_GUILD_MEMBER = 3, -- if member did it

  AVA_HISTORY_LOCATION_M = 4,
  AVA_HISTORY_CAMPAIGN_M = 5,

  AVA_HISTORY_LOCATION_NM = 3,
  AVA_HISTORY_CAMPAIGN_NM = 4,

  AVA_HISTORY_UNUSED_6 = 6,
  AVA_HISTORY_UNUSED_7 = 7,
  AVA_HISTORY_UNUSED_8 = 8,
  AVA_HISTORY_EVENTID = 9,
  AVA_HISTORY_TIMESTAMP = 10, -- this is not part of the data from server, custom value
}

--combat this seems unused
LibGuildHistoryCache.combatTableEnum = {
  COMBAT_HISTORY_EVENT_TYPE = 1,
  COMBAT_HISTORY_SECONDS_SINCE_EVENT = 2,
  COMBAT_HISTORY_GUILD_MEMBER = 3,
  COMBAT_HISTORY_UNUSED_4 = 4,
  COMBAT_HISTORY_UNUSED_5 = 5,
  COMBAT_HISTORY_UNUSED_6 = 6,
  COMBAT_HISTORY_UNUSED_7 = 7,
  COMBAT_HISTORY_UNUSED_8 = 8,
  COMBAT_HISTORY_EVENTID = 9,
  COMBAT_HISTORY_TIMESTAMP = 10, -- this is not part of the data from server, custom value
}

LibGuildHistoryCache.generalTableEnum = {
  GENERAL_HISTORY_EVENT_TYPE = 1,
  GENERAL_HISTORY_SECONDS_SINCE_EVENT = 2,
  GENERAL_HISTORY_GUILD_MEMBER = 3,
  GENERAL_HISTORY_UNUSED_4 = 4,
  GENERAL_HISTORY_UNUSED_5 = 5,
  GENERAL_HISTORY_UNUSED_6 = 6,
  GENERAL_HISTORY_UNUSED_7 = 7,
  GENERAL_HISTORY_UNUSED_8 = 8,
  GENERAL_HISTORY_EVENTID = 9,
  GENERAL_HISTORY_TIMESTAMP = 10, -- this is not part of the data from server, custom value
}

LibGuildHistoryCache.bankTableEnum = {
  BANK_HISTORY_EVENT_TYPE = 1,
  BANK_HISTORY_SECONDS_SINCE_EVENT = 2,
  BANK_HISTORY_GUILD_MEMBER = 3,
  BANK_HISTORY_QTY = 4,
  BANK_HISTORY_ITEM_LINK = 5,
  BANK_HISTORY_UNUSED_6 = 6,
  BANK_HISTORY_UNUSED_7 = 7,
  BANK_HISTORY_UNUSED_8 = 8,
  BANK_HISTORY_EVENTID = 9,
  BANK_HISTORY_TIMESTAMP = 10, -- this is not part of the data from server, custom value
}

--[[
GUILD_EVENT_ITEM_SOLD = 15
]]--
LibGuildHistoryCache.storeTableEnum = {
  STORE_HISTORY_EVENT_TYPE = 1,
  STORE_HISTORY_SECONDS_SINCE_EVENT = 2,
  STORE_HISTORY_SELLER = 3,
  STORE_HISTORY_BUYER = 4,
  STORE_HISTORY_QTY_SOLD = 5,
  STORE_HISTORY_ITEM_LINK = 6,
  STORE_HISTORY_PRICE = 7,
  STORE_HISTORY_TAXES = 8,
  STORE_HISTORY_EVENTID = 9,
  STORE_HISTORY_TIMESTAMP = 10, -- this is not part of the data from server, custom value
}

LibGuildHistoryCache.storeCategoryText = {
  [LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_EVENT_TYPE] = "Event Type",
  [LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_SECONDS_SINCE_EVENT] = "Seconds Since Event",
  [LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_SELLER] = "Seller",
  [LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_BUYER] = "Buyer",
  [LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_QTY_SOLD] = "Qty Sold",
  [LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_ITEM_LINK] = "Item Link",
  [LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_PRICE] = "Price",
  [LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_TAXES] = "Taxes",
  [LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_EVENTID] = "EventID",
  [LibGuildHistoryCache.storeTableEnum.STORE_HISTORY_TIMESTAMP] = "Timestamp", -- this is not part of the data from server, custom value
}
LibGuildHistoryCache.eventTypeText = {
  [GUILD_HISTORY_GENERAL_ROSTER] = "Roster Update",
  [GUILD_EVENT_ITEM_SOLD] = "Item Sold",
}

if LibDebugLogger then
  local logger = LibDebugLogger.Create(LibGuildHistoryCache.name)
  LibGuildHistoryCache.logger = logger
end
local SDLV = DebugLogViewer
if SDLV then LibGuildHistoryCache.viewer = true else LibGuildHistoryCache.viewer = false end

local function create_log(log_type, log_content)
  if LibGuildHistoryCache.viewer then
    if log_type == "Debug" then
      LibGuildHistoryCache.logger:Debug(log_content)
    end
    if log_type == "Verbose" then
      LibGuildHistoryCache.logger:Verbose(log_content)
    end
  else
    d(log_content)
  end
end

local function emit_message(log_type, text)
  if(text == "") then
      text = "[Empty String]"
  end
  create_log(log_type, text)
end

local function emit_table(log_type, t, indent, table_history)
  indent          = indent or "."
  table_history    = table_history or {}

  for k, v in pairs(t) do
    local vType = type(v)

    emit_message(log_type, indent.."("..vType.."): "..tostring(k).." = "..tostring(v))

    if(vType == "table") then
      if(table_history[v]) then
        emit_message(log_type, indent.."Avoiding cycle on table...")
      else
        table_history[v] = true
        emit_table(log_type, v, indent.."  ", table_history)
      end
    end
  end
end

function LibGuildHistoryCache.dm(log_type, ...)
  for i = 1, select("#", ...) do
    local value = select(i, ...)
    if(type(value) == "table") then
      emit_table(log_type, value)
    else
      emit_message(log_type, tostring(value))
    end
  end
end

-- returns guildID, megaserver, eventType
function LibGuildHistoryCache.SplitIndex(inputstr, sep)
  if sep == nil then
          sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
          table.insert(t, str)
  end
  return t[1], t[2], t[3]
end

function LibGuildHistoryCache.MegaserverGuildIDIndex(guildID, eventType)
  local index = string.format("%s@%s@%s", guildID, LibGuildHistoryCache.megaserver, eventType)
  if LibGuildHistoryCache_SavedVariables[index] == nil then LibGuildHistoryCache_SavedVariables[index] = {} end
  return index
end
