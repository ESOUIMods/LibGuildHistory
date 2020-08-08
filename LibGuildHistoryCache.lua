local megaserver = LibGuildHistoryCache.megaserver

function LibGuildHistoryCache:get_guild_info()
  local nextGuildID = GetGuildId(nextGuild)
  local nextGuildName = GetGuildName(nextGuildID)
  LibGuildHistoryCache.number_of_guilds = GetNumGuilds()
  
  for i = 1, LibGuildHistoryCache.number_of_guilds do
    LibGuildHistoryCache.guild_info[i].guild_id = GetGuildId(i)
    LibGuildHistoryCache.guild_info[i].guild_name = GetGuildName(LibGuildHistoryCache.guild_info[i].guild_id)
  end
end

--- Returns a guild events unique id
function LibGuildHistoryCache:get_guild_event_id(guild_to_scan, category, event_index)
    local event_id = GetGuildEventId(guild_to_scan, category, event_index)
    return tonumber(Id64ToString(eventId))
end

--- Handle Guild History Evert
local function OnGuildHistoryEvent(event_code, guild_id, category)
    if (event_code ~= EVENT_GUILD_HISTORY_RESPONSE_RECEIVED) then
        return
    end
   LibGuildHistoryCache.dm("Debug", "OnGuildHistoryEvent")
   LibGuildHistoryCache.dm("Debug", string.format("%s %s %s", event_code, guild_id, category))
end
EVENT_MANAGER:RegisterForEvent(LibGuildHistoryCache.name, EVENT_GUILD_HISTORY_RESPONSE_RECEIVED, OnGuildHistoryEvent)

function LibGuildHistoryCache:request_page(guild_to_scan, category, event_index)
    local event_id = GetGuildEventId(guild_to_scan, category, event_index)
    return tonumber(Id64ToString(eventId))
end

local function OnAddOnLoaded(eventCode, addOnName)
   if addOnName ~= LibGuildHistoryCache.name then return end
   LibGuildHistoryCache.dm("Debug", "LibGuildHistoryCache Loaded")
   -- setup guild names and get guild IDs first
   LibGuildHistoryCache:get_guild_info()
   RequestPage
end
EVENT_MANAGER:RegisterForEvent(LibGuildHistoryCache.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
