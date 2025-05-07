if CLIENT then 
    AddCSLuaFile("dirtymoney/cl_core.lua")
    include("dirtymoney/cl_core.lua")
end 

if SERVER then
    AddCSLuaFile("dirtymoney/cl_core.lua")
    include("dirtymoney/sv_core.lua")
end