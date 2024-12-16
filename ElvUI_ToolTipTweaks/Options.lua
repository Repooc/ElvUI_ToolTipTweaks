local E, L, _, P = unpack(ElvUI)
local AddOnName = ...
local TTT = E:GetModule(AddOnName)
LibStub('RepoocReforged-1.0'):LoadMainCategory()
local TT = E.Tooltip
local ACH = E.Libs.ACH

local function optionsTable()
	--* Repooc Reforged Plugin section
	local rrp = E.Options.args.rrp
	if not rrp then print("Error Loading Repooc Reforged Plugin Library") return end

	--* Plugin Section
	local ToolTipTweaks = ACH:Group('|cff00FF98ToolTip|r |cffA330C9Tweaks|r', nil, 6, 'tab', nil, nil, function() return not TT.Initialized end)
	rrp.args.ttt = ToolTipTweaks

	ToolTipTweaks.args.version = ACH:Header(format('|cff99ff33%s|r', TTT.Version), 1)

	--* Tooltip Location Offsets Section
	local TTPlacement = ACH:Group(L["Tooltip Placement"], nil, 1, nil, function(info) return E.db.tooltiptweaks[info[#info-1]][info[#info]] end, function(info, value) E.db.tooltiptweaks[info[#info-1]][info[#info]] = value E.Libs.AceConfigRegistry:NotifyChange('ElvUI') end)
	ToolTipTweaks.args.ttPlacement = TTPlacement

	TTPlacement.args.enable = ACH:Toggle(L["Enable"], nil, 1)
	TTPlacement.args.spacer = ACH:Spacer(2, 'full')
	TTPlacement.args.ignoreBagFrame = ACH:Toggle(L["Ignore Bag Frame"], L["By default, when ElvUI's bag frame is visible and you mouse over specific things like your actionbar buttons, ElvUI will place the Tooltip at the top of the bag frame. This will ignore the bag frame and place the tooltip with the mover."], 5, nil, nil, nil, nil, nil, function() return not TT.Initialized or not E.db.tooltiptweaks.ttPlacement.enable end)
	TTPlacement.args.ignoreRightChatPanel = ACH:Toggle(L["Ignore Right Chat Panel"], L["By default, when ElvUI's Right Chat Panel is visible and you mouse over specific things like your actionbars, ElvUI will place the Tooltip at the top of the right chat panel frame. This will ignore the right chat panel frame and place the tooltip with the mover."], 6, nil, nil, nil, nil, nil, function() return not TT.Initialized or not E.db.tooltiptweaks.ttPlacement.enable end)
	TTPlacement.args.spacer2 = ACH:Spacer(10, 'full')

	--* General Section
	local General = ACH:Group(L["General"], nil, 15, nil, function(info) return E.db.tooltiptweaks[info[#info-2]][info[#info-1]][info[#info]] end, function(info, value) E.db.tooltiptweaks[info[#info-2]][info[#info-1]][info[#info]] = value end, function() return not TT.Initialized or not E.db.tooltiptweaks.ttPlacement.enable end)
	TTPlacement.args.general = General
	General.args.useDefault = ACH:Toggle(L["Use Default Padding"], L["Use this option to use the default values that ElvUI uses."], 5, nil, nil, nil, nil, nil, function() return not TT.Initialized or not E.db.tooltiptweaks.ttPlacement.enable end)
	General.args.spacer = ACH:Spacer(10, 'full')
	General.args.xOffset = ACH:Range(L["X Offset"], nil, 11, { min = -250, max = 250, step = 1 }, nil, nil, nil, function() return not TT.Initialized or not E.db.tooltiptweaks.ttPlacement.enable or E.db.tooltiptweaks.ttPlacement.general.useDefault end)
	General.args.yOffset = ACH:Range(L["Y Offset"], nil, 12, { min = -250, max = 250, step = 1 }, nil, nil, nil, function() return not TT.Initialized or not E.db.tooltiptweaks.ttPlacement.enable or E.db.tooltiptweaks.ttPlacement.general.useDefault end)

	--* Bags Section
	local Bags = ACH:Group(L["Bags"], nil, 16, nil, function(info) return E.db.tooltiptweaks[info[#info-2]][info[#info-1]][info[#info]] end, function(info, value) E.db.tooltiptweaks[info[#info-2]][info[#info-1]][info[#info]] = value end, function() return not TT.Initialized or not E.db.tooltiptweaks.ttPlacement.enable end)
	TTPlacement.args.bags = Bags
	Bags.args.warning = ACH:Description(format('%s%s|r', '|cffFF3300', L["The tooltip mover has been moved by the user or has selected the option to ignore the bag frame, in which these options will be ignored. It will follow the settings in the General section."]), 1, 'medium', nil, nil, nil, nil, 'full', function() if E:HasMoverBeenMoved('TooltipMover') then return false elseif E.db.tooltiptweaks.ttPlacement.ignoreBagFrame then return false else return true end end)
	Bags.args.useDefault = ACH:Toggle(L["Use Default Padding"], L["Use this option to use the default values that ElvUI uses."], 5, nil, nil, nil, nil, nil, function(info) return not TT.Initialized or not E.db.tooltiptweaks.ttPlacement.enable or E.db.tooltiptweaks.ttPlacement.ignoreBagFrame end)
	Bags.args.spacer = ACH:Spacer(10, 'full')
	Bags.args.xOffset = ACH:Range(L["X Offset"], nil, 11, { min = -250, max = 250, step = 1 }, nil, nil, nil, function() return not TT.Initialized or not E.db.tooltiptweaks.ttPlacement.enable or E.db.tooltiptweaks.ttPlacement.ignoreBagFrame or E.db.tooltiptweaks.ttPlacement.bags.useDefault end)
	Bags.args.yOffset = ACH:Range(L["Y Offset"], nil, 12, { min = -250, max = 250, step = 1 }, nil, nil, nil, function() return not TT.Initialized or not E.db.tooltiptweaks.ttPlacement.enable or E.db.tooltiptweaks.ttPlacement.ignoreBagFrame or E.db.tooltiptweaks.ttPlacement.bags.useDefault end)

	--* Right Chat Panel Section
	local RightChatPanel = ACH:Group(L["Right Chat Panel"], nil, 16, nil, function(info) return E.db.tooltiptweaks[info[#info-2]][info[#info-1]][info[#info]] end, function(info, value) E.db.tooltiptweaks[info[#info-2]][info[#info-1]][info[#info]] = value end, function() return not TT.Initialized or not E.db.tooltiptweaks.ttPlacement.enable end)
	TTPlacement.args.rightchatpanel = RightChatPanel
	RightChatPanel.args.warning = ACH:Description(format('%s%s|r', '|cffFF3300', L["The tooltip mover has been moved by the user or has selected the option to ignore the right chat panel, in which these options will be ignored. It will follow the settings in the General section."]), 1, 'medium', nil, nil, nil, nil, 'full', function() if E:HasMoverBeenMoved('TooltipMover') then return false elseif E.db.tooltiptweaks.ttPlacement.ignoreRightChatPanel then return false else return true end end)
	RightChatPanel.args.useDefault = ACH:Toggle(L["Use Default Padding"], L["Use this option to use the default values that ElvUI uses."], 5, nil, nil, nil, nil, nil, function() return not TT.Initialized or not E.db.tooltiptweaks.ttPlacement.enable or E.db.tooltiptweaks.ttPlacement.ignoreRightChatPanel end)
	RightChatPanel.args.spacer = ACH:Spacer(10, 'full')
	RightChatPanel.args.xOffset = ACH:Range(L["X Offset"], nil, 11, { min = -250, max = 250, step = 1 }, nil, nil, nil, function() return not TT.Initialized or not E.db.tooltiptweaks.ttPlacement.enable or E.db.tooltiptweaks.ttPlacement.ignoreRightChatPanel or E.db.tooltiptweaks.ttPlacement.rightchatpanel.useDefault end)
	RightChatPanel.args.yOffset = ACH:Range(L["Y Offset"], nil, 12, { min = -250, max = 250, step = 1 }, nil, nil, nil, function() return not TT.Initialized or not E.db.tooltiptweaks.ttPlacement.enable or E.db.tooltiptweaks.ttPlacement.ignoreRightChatPanel or E.db.tooltiptweaks.ttPlacement.rightchatpanel.useDefault end)

	--* Health Section
	local Health = ACH:Group(L["Health"], nil, 2, nil, function(info) return E.db.tooltiptweaks[info[#info-1]][info[#info]] end, function(info, value) E.db.tooltiptweaks[info[#info-1]][info[#info]] = value TTT.firstRunHealth = true end, function(info) if info[#info] == 'healthBar' then return false elseif info[#info] ~= 'enable' then return not E.db.tooltiptweaks.healthBar.enable end end)
	ToolTipTweaks.args.healthBar = Health
	Health.args.enable = ACH:Toggle(L["Enable"], nil, 1)
	Health.args.spacer = ACH:Spacer(2, 'full')
	Health.args.spacing = ACH:Range(L["Spacing"], nil, 5, { min = 0, max = 10, step = 1 })

	--* Help Tab
	local Help = ACH:Group(L["Help"], nil, 99, nil, nil, nil, false)
	ToolTipTweaks.args.help = Help

	local Support = ACH:Group(L["Support"], nil, 1)
	Help.args.support = Support
	Support.inline = true
	Support.args.wago = ACH:Execute(L["Wago Page"], nil, 1, function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://addons.wago.io/addons/tooltip-tweaks-elvui-plugin') end, nil, nil, 140)
	Support.args.curse = ACH:Execute(L["Curseforge Page"], nil, 1, function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://www.curseforge.com/wow/addons/tooltip-tweaks-elvui-plugin') end, nil, nil, 140)
	Support.args.git = ACH:Execute(L["Ticket Tracker"], nil, 2, function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://github.com/Repooc/ElvUI_ToolTipTweaks/issues') end, nil, nil, 140)
	Support.args.discord = ACH:Execute(L["Discord"], nil, 3, function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://repoocreforged.dev/discord') end, nil, nil, 140)

	local Download = ACH:Group(L["Download"], nil, 2)
	Help.args.download = Download
	Download.inline = true
	Download.args.development = ACH:Execute(L["Development Version"], L["Link to the latest development version."], 1, function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://github.com/Repooc/ElvUI_ToolTipTweaks/archive/refs/heads/main.zip') end, nil, nil, 140)
	-- Download.args.changelog = ACH:Execute(L["Changelog"], nil, 3, function() if ABB_Changelog and ABB_Changelog:IsShown() then ABB:Print('ActionBar Masks changelog is already being displayed.') else ABBCL:ToggleChangeLog() end end, nil, nil, 140)
end
tinsert(TTT.Options, optionsTable)
