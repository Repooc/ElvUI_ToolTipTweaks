local E = unpack(ElvUI)
local EP = E.Libs.EP
local TT = E.Tooltip

local AddOnName = ...

local TTT = E:NewModule(AddOnName, 'AceHook-3.0')

TTT.Title = C_AddOns.GetAddOnMetadata(AddOnName, 'Title')
TTT.Version = C_AddOns.GetAddOnMetadata(AddOnName, 'Version')
TTT.Options = {}

local function GetOptions()
	for _, func in pairs(TTT.Options) do
		func()
	end
end
local function ResetMovers(_, arg)
	local all = not arg or arg == ''

	if arg == 'Tooltip' or all then
		E.Libs.AceConfigRegistry:NotifyChange('ElvUI')
	end
end

local function Initialize()
	EP:RegisterPlugin(AddOnName, GetOptions)
	if not TT.Initialized then return end

	TTT:SecureHook(TT, 'GameTooltip_SetDefaultAnchor', TTT.GameTooltip_SetDefaultAnchor)
	TTT:SecureHook(E, 'ResetMovers', ResetMovers)
	TooltipMover:HookScript('OnDragStop', function() ResetMovers(nil, 'Tooltip') end)
end
EP:HookInitialize(TTT, Initialize)
