local helmetEnabled = true

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
