local clientPanel

function generateClientPanel(panel)
	clientPanel = panel
	panel:ClearControls()
	for k,v in pairs(player.GetAll()) do
		if v ~= LocalPlayer() then
			local cb = panel:CheckBox(v:GetName())
			function cb:OnChange(value)
				net.Start("xandaros_prop_protection_changefriend")
					net.WriteUInt(v:UniqueID(), 32)
					net.WriteBit(value)
				net.SendToServer()
			end
		end
	end
end

hook.Add("OnSpawnMenuOpen", "xandaros_prop_protection", function()
	if clientPanel then generateClientPanel(clientPanel) end
end)

hook.Add("PopulateToolMenu", "xandaros_prop_protection", function()
	spawnmenu.AddToolMenuOption("Utilities", "XPP", "xandaros_prop_protection_client", "Client", "", "", generateClientPanel)
end)
