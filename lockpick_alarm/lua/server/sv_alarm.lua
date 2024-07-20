


util.AddNetworkString('lockpickAlarm')

local withAlarmSystem = {}


--Основные функции--

local function addAlarmSys(ent) -- Добавление энтити двери в кэш

    if not IsValid(ent) then return false end

    local entityID = ent:EntIndex()

    for _, v in ipairs(withAlarmSystem) do
        if v == entityID then
            return false

        end  
    end

    table.insert(withAlarmSystem, entityID)
    return true

end





hook.Add('PlayerSay', 'addAlarmSys', function(ply, txt) -- Установка сигнализации на дверь
    
    if string.lower(txt) == '!addalarm' then
        local trace = ply:GetEyeTrace()
        local entity = trace.Entity

        if entity:GetClass() ~= 'prop_door_rotating' then
            return false 

        end

        addAlarmSys(entity) 
        if addAlarmSys then
            ply:ChatPrint('Сигнализация успешно установлена!')

        end
    end

    return ""
end)





local function hasAlarmSys(ent) -- Проверка наличия сигнализации
    if not IsValid(ent) then return false end
    local entID = ent:EntIndex()

    for _, v in ipairs(withAlarmSystem) do
        if v == entID then
            return true

        end
    end
end



hook.Add('onLockpickCompleted', 'alarmSystem', function(ply, success, ent) -- Работа сигнализации при взломе
    local hasAlarmSystem = hasAlarmSys(ent)

    if hasAlarmSystem and success then
        local doorData = ent:getDoorData()
        local ownerID = doorData['owner']

        if ownerID == nil then
            return 

        else
            local owner = Player(ownerID)
            local isLockpick = true
            
            net.Start('lockpickAlarm')
                net.WriteBool(isLockpick)
            net.Send(owner)

        end
    end
end)
