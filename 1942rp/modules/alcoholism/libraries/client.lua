--------------------------------------------------------------------------------------------------------
function AlcoholismCore:RenderScreenspaceEffects()
    if LocalPlayer():GetNW2Int("lia_alcoholism_bac", 0) > 0 then
        DrawMotionBlur(AlcoholismCore.AddAlpha, LocalPlayer():GetNW2Int("lia_alcoholism_bac", 0) / 100, AlcoholismCore.EffectDelay)
    end
end
--------------------------------------------------------------------------------------------------------
function AlcoholismCore:DrawCharInfo(client, character, info)
    if client:IsDrunk() then
        info[#info + 1] = {"This Person Is Heavily Intoxicated", Color(245, 215, 110)}
    end
end
--------------------------------------------------------------------------------------------------------