local p = FindMetaTable("Player")

function p:GetDirtyMoney()
    return self:GetNW2Int("dirtymoney") or 0
end