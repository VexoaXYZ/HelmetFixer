local function GetResourceVersion(resourceName)
    local version = GetResourceMetadata(resourceName, "version", 0)
    if not version then
        print("[My Script] Error getting version for resource: " .. resourceName)
    end
    return version
end

local helmetEnabled = true
local githubResourceName = "HelmetFixer"
local githubUsername = "VexoaXYZ"
local currentVersion = GetResourceVersion(GetCurrentResourceName())

-- Function to toggle helmet keeping on/off
function ToggleHelmetKeeping()
  helmetEnabled = not helmetEnabled
  if helmetEnabled then
    TriggerEvent('chat:addMessage', { args = { '^1[Helmet Keeping]', '^7The helmet-keeping feature has been disabled.' } })
    -- This is when the helmet is disabled
  else
    TriggerEvent('chat:addMessage', { args = { '^1[Helmet Keeping]', '^7The helmet-keeping feature has been enabled.' } })
    -- This is when the helmet is enabled
  end
end

-- Register command to toggle helmet keeping on/off
RegisterCommand('helmets', function(source, args)
  ToggleHelmetKeeping()
end)


if(helmetEnabled) then
  CreateThread(function()
      while true do
          Wait(0)
          SetPedResetFlag(PlayerPedId(), 337, true)
      end
  end)
end

Citizen.CreateThread(function()
  PerformHttpRequest("https://raw.githubusercontent.com/" .. githubUsername .. "/" .. githubResourceName .. "/master/version.txt", function(errorCode, resultData, resultHeaders)
      if errorCode ~= 200 then
          print("[Creative Solutions] Error checking for update: " .. errorCode)
          return
      end
      local latestVersion = string.gsub(resultData, "\n", "")
      if currentVersion ~= latestVersion then
          print("[Creative Solutions] A new version is available (" .. latestVersion .. "). Please update.")
      end
  end, "GET", "", {})
end)