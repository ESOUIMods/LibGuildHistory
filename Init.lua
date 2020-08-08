LibGuildHistoryCache = {}
LibGuildHistoryCache.name = 'LibGuildHistoryCache'
LibGuildHistoryCache.version = '1.0'
LibGuildHistoryCache.client_lang = GetCVar("language.2")
LibGuildHistoryCache.megaserver = GetWorldName()
LibGuildHistoryCache.isScanning = false
LibGuildHistoryCache.isScanningParallel = {}
LibGuildHistoryCache.guildhistory = {}
LibGuildHistoryCache.number_of_guilds = 0
LibGuildHistoryCache.guild_info = {
  [1] = { guild_id = 0, guild_name = 0, },
  [2] = { guild_id = 0, guild_name = 0, },
  [3] = { guild_id = 0, guild_name = 0, },
  [4] = { guild_id = 0, guild_name = 0, },
  [5] = { guild_id = 0, guild_name = 0, },
}
LibGuildHistoryCache_Data = {
 [LibGuildHistoryCache.megaserver] = {},
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
