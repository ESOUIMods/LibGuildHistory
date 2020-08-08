local num_guilds

function LibGuildHistoryCache:get_guild_info()
  local nextGuildID = GetGuildId(nextGuild)
  local nextGuildName = GetGuildName(nextGuildID)
  LibGuildHistoryCache.number_of_guilds = GetNumGuilds()
  
  for i = 1, LibGuildHistoryCache.number_of_guilds do
    LibGuildHistoryCache.guild_info[i].guild_id = GetGuildId(i)
    LibGuildHistoryCache.guild_info[i].guild_name = GetGuildName(LibGuildHistoryCache.guild_info[i].guild_id)
  end
end

function LibGuildHistoryCache:request_scan(guild_to_scan)
  if LibGuildHistoryCache.guild_history[guild_to_scan] == nil then LibGuildHistoryCache.guild_history[guild_to_scan] = {} end
  LibGuildHistoryCache.guild_history[guild_to_scan] = GetGuildEventInfo(guild_to_scan, GUILD_HISTORY_STORE)
end

function LibGuildHistoryCache:start_scan()
  LibGuildHistoryCache:request_scan(LibGuildHistoryCache.guild_info[4].guild_id, GUILD_HISTORY_STORE)
end

local function OnAddOnLoaded(eventCode, addOnName)
   if addOnName ~= LibGuildHistoryCache.name then return end
   LibGuildHistoryCache.dm("Debug", "LibGuildHistoryCache Loaded")
   -- setup guild names and get guild IDs first
   LibGuildHistoryCache:get_guild_info()
   -- start scan for test guild
   LibGuildHistoryCache:start_scan()
end
EVENT_MANAGER:RegisterForEvent(LibGuildHistoryCache.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)

