local E, L, V, P, G = unpack(ElvUI)
local AddOnName = ...
local TTT = E:GetModule(AddOnName)
local AB = E.ActionBars
local B = E.Bags
local TT = E.Tooltip

local InCombatLockdown = InCombatLockdown

function TTT:GameTooltip_SetDefaultAnchor(tt, parent, a)
	if not E.db.tooltiptweaks.enable then return end
	if not E.private.tooltip.enable or not TT.db.visibility or tt:IsForbidden() or tt:GetAnchorType() ~= 'ANCHOR_NONE' then
		return
	elseif (InCombatLockdown() and not TT:IsModKeyDown(TT.db.visibility.combatOverride)) or (not AB.KeyBinder.active and not TT:IsModKeyDown(TT.db.visibility.actionbars) and AB.handledbuttons[tt:GetOwner()]) then
		-- tt:Hide()
		return
	end

	if parent and TT.db.cursorAnchor then
        return
	end

    local RightChatPanel = _G.RightChatPanel
	local TooltipMover = _G.TooltipMover
	local _, anchor = tt:GetPoint()

	if anchor == nil or anchor == B.BagFrame or anchor == RightChatPanel or anchor == TooltipMover or anchor == _G.GameTooltipDefaultContainer or anchor == _G.UIParent or anchor == E.UIParent then
		tt:ClearAllPoints()

		local db = E.db.tooltiptweaks
		if not E:HasMoverBeenMoved('TooltipMover') then
			if not db.padding.ignoreBagFrame and B.BagFrame and B.BagFrame:IsShown() then
				-- tt:Point('BOTTOMRIGHT', B.BagFrame, 'TOPRIGHT', 0, 18 + db.xOffset)
				tt:Point('BOTTOMRIGHT', B.BagFrame, 'TOPRIGHT', 0, 18)
			elseif RightChatPanel:GetAlpha() == 1 and RightChatPanel:IsShown() then
				-- tt:Point('BOTTOMRIGHT', RightChatPanel, 'TOPRIGHT', 0, 18 + db.xOffset)
				tt:Point('BOTTOMRIGHT', RightChatPanel, 'TOPRIGHT', 0, 18)
			else
				tt:Point('BOTTOMRIGHT', RightChatPanel, 'BOTTOMRIGHT', db.padding.xOffset, db.padding.useDefaultPadding and 18 + db.padding.yOffset or db.padding.yOffset)
			end
		else
			local point = E:GetScreenQuadrant(TooltipMover)
			if point == 'TOPLEFT' then
				tt:Point('TOPLEFT', TooltipMover, 'BOTTOMLEFT', db.padding.useDefaultPadding and 1 + db.padding.xOffset or db.padding.xOffset, db.padding.useDefaultPadding and -4 + db.padding.yOffset or db.padding.yOffset)
			elseif point == 'TOPRIGHT' then
				tt:Point('TOPRIGHT', TooltipMover, 'BOTTOMRIGHT', db.padding.useDefaultPadding and -1 + db.padding.xOffset or db.padding.xOffset, db.padding.useDefaultPadding and -4 + db.padding.yOffset or db.padding.yOffset)
			elseif point == 'BOTTOMLEFT' or point == 'LEFT' then
				tt:Point('BOTTOMLEFT', TooltipMover, 'TOPLEFT', db.padding.useDefaultPadding and 1 + db.padding.xOffset or db.padding.xOffset, db.padding.useDefaultPadding and 18 + db.padding.yOffset or db.padding.yOffset)
			else
				tt:Point('BOTTOMRIGHT', TooltipMover, 'TOPRIGHT', db.padding.useDefaultPadding and -1 + db.padding.xOffset or db.padding.xOffset, db.padding.useDefaultPadding and 18 + db.padding.yOffset or db.padding.yOffset)
			end
		end
	end
end
