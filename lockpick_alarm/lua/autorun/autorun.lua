


if SERVER then 
    include('server/sv_alarm.lua')
    AddCSLuaFile('client/cl_alarm.lua')
end

if CLIENT then
    include('client/cl_alarm.lua')
end