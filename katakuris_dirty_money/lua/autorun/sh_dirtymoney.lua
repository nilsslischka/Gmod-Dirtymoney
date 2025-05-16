DIRTYMONEY_CFG = DIRTYMONEY_CFG or {}

DIRTYMONEY_CFG.StartingAmount = 0


local p = FindMetaTable("Player")

function p:GetDirtyMoney()
    return self:GetNW2Int("dirtymoney") or 0
end