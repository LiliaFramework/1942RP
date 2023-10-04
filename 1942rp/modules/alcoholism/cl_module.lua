--------------------------------------------------------------------------------------------------------
function MODULE:RenderScreenspaceEffects()
    if LocalPlayer():GetNW2Int("lia_alcoholism_bac", 0) > 0 then
        DrawMotionBlur(lia.config.AlcoholismAddAlpha, LocalPlayer():GetNW2Int("lia_alcoholism_bac", 0) / 100, lia.config.AlcoholismEffectDelay)
    end
end
--------------------------------------------------------------------------------------------------------