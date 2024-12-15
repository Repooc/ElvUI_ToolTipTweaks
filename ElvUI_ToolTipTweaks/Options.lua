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

	--* General Tab
	local General = ACH:Group(L["General"], nil, 1, nil, function(info) return E.db.tooltiptweaks[info[#info]] end, function(info, value) E.db.tooltiptweaks[info[#info]] = value end, function() return not TT.Initialized end)
	ToolTipTweaks.args.general = General
	General.args.enable = ACH:Toggle(L["Enable"], nil, 1)
	-- ACH:Toggle(name, desc, order, tristate, confirm, width, get, set, disabled, hidden)

	--* Padding Section
	local Padding = ACH:Group(L["Padding"], nil, 1, nil, function(info) return E.db.tooltiptweaks.padding[info[#info]] end, function(info, value) E.db.tooltiptweaks.padding[info[#info]] = value end, function() return not E.db.tooltiptweaks.enable end)
	General.args.padding = Padding
	Padding.inline = true
	Padding.args.useDefaultPadding = ACH:Toggle(L["Use Default Padding"], L["Use this option to use the default padding values that ElvUI uses in addition to the values you set in this section."], 1)
	Padding.args.ignoreBagFrame = ACH:Toggle(L["Ignore Bag Frame"], L["By default, when your ElvUI bags are shown while mousing over specific things like your actionbars, ElvUI will place the ToolTip at the top of the bag frame. This will ignore the bag frame and place the tooltip with the mover."], 2)
	Padding.args.xOffset = ACH:Range(L["X Offset"], nil, 2, { min = -250, max = 250, step = 1 })
	Padding.args.yOffset = ACH:Range(L["Y Offset"], nil, 3, { min = -250, max = 250, step = 1 })

	--* Health Section
	local Health = ACH:Group(L["Health"], nil, 2, nil, function(info) return E.db.tooltiptweaks[info[#info-1]][info[#info]] end, function(info, value) E.db.tooltiptweaks[info[#info-1]][info[#info]] = value TTT.firstRunHealth = true end)
	General.args.healthBar = Health
	Health.inline = true
	Health.args.enable = ACH:Toggle(L["Enable"], nil, 1)
	Health.args.spacer = ACH:Spacer(2, 'full')
	Health.args.spacing = ACH:Range(L["Spacing"], nil, 5, { min = 0, max = 20, step = 1 })

	-- ACH:Range(name, desc, order, values, width, get, set, disabled, hidden)
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
