hook.Add("Initialize", "DirtyMoney_SetUpDataTable", function()
    if sql.TableExists("dirtymoney") then return end
    sql.Query("CREATE TABLE dirtymoney (steamid NUMBER, money NUMBER)")
end)

hook.Add("PlayerInitialSpawn", "DirtyMoney_InsertDefaultValues", function(ply)
    local id = ply:SteamID64()
    local data = sql.Query("SELECT * FROM dirtymoney WHERE steamid=" .. id )

    if not (data) then
        sql.Query("INSERT INTO dirtymoney(steamid, money) VALUES(" .. id .. ", ".. DIRTYMONEY_CFG.StartingAmount .. ")")
        ply:SetNW2Int("dirtymoney", 0)
    else 
        ply:SetNW2Int("dirtymoney", tonumber(data[1].money))
    end
end)

-- meta Functions
local p = FindMetaTable("Player")

function p:SetDirtyMoney(amount)
    local id = self:SteamID64()
    local data = sql.Query("SELECT * FROM dirtymoney WHERE steamid=" .. id )

    self:SetNW2Int("dirtymoney", amount)
    sql.Query("UPDATE dirtymoney SET money = " .. amount .. " WHERE steamid=" .. id )
end 

function p:AddDirtyMoney(amount)
    local id = self:SteamID64()
    local data = sql.Query("SELECT * FROM dirtymoney WHERE steamid=" .. id )

    self:SetNW2Int("dirtymoney", tonumber(data[1].money) + amount)
    sql.Query("UPDATE dirtymoney SET money = money + " .. amount .. " WHERE steamid=" .. id )
end 

function p:RemoveDirtyMoney(amount)
    local id = self:SteamID64()
    local data = sql.Query("SELECT * FROM dirtymoney WHERE steamid=" .. id )

    self:SetNW2Int("dirtymoney", tonumber(data[1].money) - amount)
    sql.Query("UPDATE dirtymoney SET money = money - " .. amount .. " WHERE steamid=" .. id )
end 

-- remove dirtymoney on playerdeath
hook.Add("PlayerDeath", "DirtyMoney_RemoveOnDeath", function(victim, inflictor, attacker)
    if not IsValid(victim) then return end
    if victim:GetDirtyMoney() < 200 then return end 
    victim:RemoveDirtyMoney(victim:GetDirtyMoney() * .25)
end)


/*
sql.m_strError = nil -- This is required to invoke __newindex

setmetatable(sql, { __newindex = function( table, k, v )
	if k == "m_strError" and v then
		print("[SQL Error] " .. v )
	end
end } )
*/