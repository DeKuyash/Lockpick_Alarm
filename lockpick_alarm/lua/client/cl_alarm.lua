


net.Receive('lockpickAlarm', function()
    local isLockpick = net.ReadBool(isLockpick)

    if isLockpick then
        chat.AddText(Color(255, 0, 0), '[ТРЕВОГА] ', Color(255, 255, 255), tostring(LocalPlayer():GetName()), ', вашу дверь взломали!')

    end
end)