LibGuildHistoryCache = {}
LibGuildHistoryCache.name = 'LibGuildHistoryCache'
LibGuildHistoryCache.version = '1.0'
LibGuildHistoryCache.clientLang = GetCVar("language.2")
LibGuildHistoryCache.megaserver = GetWorldName()
LibGuildHistoryCache.isScanning = false
LibGuildHistoryCache.isScanningParallel = {}
LibGuildHistoryCache.guildHistory = {}
LibGuildHistoryCache.numberOfGuilds = 0
LibGuildHistoryCache.guildInfo = {
  [1] = { guildId = 0, guildName = 0, },
  [2] = { guildId = 0, guildName = 0, },
  [3] = { guildId = 0, guildName = 0, },
  [4] = { guildId = 0, guildName = 0, },
  [5] = { guildId = 0, guildName = 0, },
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
  [LibGuildHistoryCache.categoryEnum.GUILD_HISTORY_ALLIANCE_WAR] = "Alliance War",
  [LibGuildHistoryCache.categoryEnum.GUILD_HISTORY_BANK] = "Bank",
  [LibGuildHistoryCache.categoryEnum.GUILD_HISTORY_COMBAT] = "Combat",
  [LibGuildHistoryCache.categoryEnum.GUILD_HISTORY_GENERAL] = "General",
  [LibGuildHistoryCache.categoryEnum.GUILD_HISTORY_STORE] = "Store",
}

if LibDebugLogger then
  local logger = LibDebugLogger.Create(LibGuildHistoryCache.name)
  LibGuildHistoryCache.logger = logger
end
local SDLV = DebugLogViewer
if SDLV then LibGuildHistoryCache.viewer = true else LibGuildHistoryCache.viewer = false end

local function create_log(log_type, log_content)
  if log_type == "Debug" then
    LibGuildHistoryCache.logger:Debug(log_content)
  end
  if log_type == "Verbose" then
    LibGuildHistoryCache.logger:Verbose(log_content)
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
  if not LibGuildHistoryCache.logger then return end
  for i = 1, select("#", ...) do
    local value = select(i, ...)
    if(type(value) == "table") then
      emit_table(log_type, value)
    else
      emit_message(log_type, tostring(value))
    end
  end
end
