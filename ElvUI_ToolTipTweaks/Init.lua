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

function TTT:UpdateOptions()
    if E.db.tooltiptweaks.enable and not TTT:IsHooked(TT, 'GameTooltip_SetDefaultAnchor') then
        TTT:SecureHook(TT, 'GameTooltip_SetDefaultAnchor', TTT.GameTooltip_SetDefaultAnchor)
	elseif TTT:IsHooked(TT, 'GameTooltip_SetDefaultAnchor') then
        TTT:Unhook(TT, 'GameTooltip_SetDefaultAnchor')
    end
end

local function Initialize()
    EP:RegisterPlugin(AddOnName, GetOptions)
    TTT:SecureHook(E, 'UpdateDB', TTT.UpdateOptions)

	TTT:UpdateOptions()
end
EP:HookInitialize(TTT, Initialize)
