local E, L, V, P, G = unpack(ElvUI)
local AddOnName = ...
local TTT = E:GetModule(AddOnName)
local AB = E.ActionBars
local B = E.Bags
local TT = E.Tooltip

local InCombatLockdown = InCombatLockdown

TTT.firstRunHealth = true
function TTT:GameTooltip_SetDefaultAnchor(tt, parent)
	if not E.private.tooltip.enable or not TT.db.visibility or tt:IsForbidden() or tt:GetAnchorType() ~= 'ANCHOR_NONE' then
		return
	elseif (InCombatLockdown() and not TT:IsModKeyDown(TT.db.visibility.combatOverride)) or (not AB.KeyBinder.active and not TT:IsModKeyDown(TT.db.visibility.actionbars) and AB.handledbuttons[tt:GetOwner()]) then
		return
	end

	local db = E.db.tooltiptweaks
	if not db then return end

	local statusBar = tt.StatusBar
	local position = TT.db.healthBar.statusPosition
	if statusBar and db.healthBar.enable then
		local spacing = (E.Spacing * 3) + (db.healthBar.spacing or 0)

		if position == 'BOTTOM' and (TTT.firstRunHealth or statusBar.TTT_anchoredToTop) then
			statusBar:ClearAllPoints()
			statusBar:Point('TOPLEFT', tt, 'BOTTOMLEFT', E.Border, -spacing)
			statusBar:Point('TOPRIGHT', tt, 'BOTTOMRIGHT', -E.Border, -spacing)
			statusBar.TTT_anchoredToTop = nil
		elseif position == 'TOP' and (TTT.firstRunHealth or not statusBar.TTT_anchoredToTop) then
			statusBar:ClearAllPoints()
			statusBar:Point('BOTTOMLEFT', tt, 'TOPLEFT', E.Border, spacing)
			statusBar:Point('BOTTOMRIGHT', tt, 'TOPRIGHT', -E.Border, spacing)
			statusBar.TTT_anchoredToTop = true
		end

		TTT.firstRunHealth = false
	elseif statusBar and TTT.firstRunHealth and not db.healthBar.enable then
		if position == 'BOTTOM' then
			statusBar.anchoredToTop = true
		elseif position == 'TOP' then
			statusBar.anchoredToTop = nil
		end

		TTT.firstRunHealth = false
	end

	if not db.ttPlacement.enable then return end

	if parent and TT.db.cursorAnchor then
        return
	end

	local RightChatPanel = _G.RightChatPanel
	local TooltipMover = _G.TooltipMover
	local _, anchor = tt:GetPoint()

	if anchor == nil or anchor == B.BagFrame or anchor == RightChatPanel or anchor == TooltipMover or anchor == _G.GameTooltipDefaultContainer or anchor == _G.UIParent or anchor == E.UIParent then
		tt:ClearAllPoints()

		if not E:HasMoverBeenMoved('TooltipMover') then
			if not db.ttPlacement.ignoreBagFrame and B.BagFrame and B.BagFrame:IsShown() then
				tt:Point('BOTTOMRIGHT', B.BagFrame, 'TOPRIGHT', db.ttPlacement.bags.useDefault and 0 or db.ttPlacement.bags.xOffset, db.ttPlacement.bags.useDefault and 18 or db.ttPlacement.bags.yOffset)
			elseif not db.ttPlacement.ignoreRightChatPanel and RightChatPanel:GetAlpha() == 1 and RightChatPanel:IsShown() then
				tt:Point('BOTTOMRIGHT', RightChatPanel, 'TOPRIGHT', db.ttPlacement.rightchatpanel.useDefault and 0 or db.ttPlacement.rightchatpanel.xOffset, db.ttPlacement.rightchatpanel.useDefault and 18 or db.ttPlacement.rightchatpanel.yOffset)
			else
				tt:Point('BOTTOMRIGHT', RightChatPanel, 'BOTTOMRIGHT', db.ttPlacement.general.useDefault and 0 or db.ttPlacement.general.xOffset, db.ttPlacement.general.useDefault and 18 or db.ttPlacement.general.yOffset)
			end
		else
			local point = E:GetScreenQuadrant(TooltipMover)
			if point == 'TOPLEFT' then
				tt:Point('TOPLEFT', TooltipMover, 'BOTTOMLEFT', db.ttPlacement.general.useDefault and 1 or db.ttPlacement.general.xOffset, db.ttPlacement.general.useDefault and -4 or db.ttPlacement.general.yOffset)
			elseif point == 'TOPRIGHT' then
				tt:Point('TOPRIGHT', TooltipMover, 'BOTTOMRIGHT', db.ttPlacement.general.useDefault and -1 or db.ttPlacement.general.xOffset, db.ttPlacement.general.useDefault and -4 or db.ttPlacement.general.yOffset)
			elseif point == 'BOTTOMLEFT' or point == 'LEFT' then
				tt:Point('BOTTOMLEFT', TooltipMover, 'TOPLEFT', db.ttPlacement.general.useDefault and 1 or db.ttPlacement.general.xOffset, db.ttPlacement.general.useDefault and 18 or db.ttPlacement.general.yOffset)
			else
				tt:Point('BOTTOMRIGHT', TooltipMover, 'TOPRIGHT', db.ttPlacement.general.useDefault and -1 or db.ttPlacement.general.xOffset, db.ttPlacement.general.useDefault and 18 or db.ttPlacement.general.yOffset)
			end
		end
	end
end
