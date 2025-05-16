-- HUD locals

local w, h = ScrW(), ScrH()
local width, height = w * .1, h * .05
local color_base = Color(0, 0, 0, 220)
local color_text = Color(200, 0, 0)
local color_outline = Color(200, 200, 200, 255)


-- font
surface.CreateFont( "dirtmoney_main", {
    font = "Montserrat",
    size = (h / 1080) * 20,
    weight = 800,
} )

-- HUD Drawing
hook.Add("HUDPaint", "Dirtymoney:DrawHUD", function()
    if not LocalPlayer():Alive() then return end 

    surface.SetDrawColor(color_base)
    surface.DrawRect(5, h / 2 - (height / 2), width, height)

    surface.SetDrawColor(color_outline)
    surface.DrawOutlinedRect(5, h / 2 - (height / 2), width, height)

    draw.SimpleText("Dirty Money: "..LocalPlayer():GetDirtyMoney(), "dirtmoney_main", 5 + (width / 2) , h / 2, color_text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)