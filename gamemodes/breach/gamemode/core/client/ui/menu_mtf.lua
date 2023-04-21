
nextmenudelete = 0
showmenu = false

function CloseMTFMenu()
	if ispanel(MtfMenu_Frame) and MtfMenu_Frame.Close then
		MtfMenu_Frame:Close()
	end
end

local button_height = 32

function OpenMenu()
	--if true then return end -- DEBUG

	local client = LocalPlayer()
	if IsValid(MtfMenu_Frame) or !client:Alive() or client:IsSpectator() then return end
	
	local spa = {}

	for k,v in pairs(SPECIAL_ACTIONS) do
		if v.condition(client) then
			table.ForceInsert(spa, v)
		end
	end

	if table.Count(spa) < 1 then return end
	
	MtfMenu_Frame = vgui.Create("DFrame")
	MtfMenu_Frame:SetTitle("")
	MtfMenu_Frame:SetSize(375, 60 + (table.Count(spa) * (button_height+5)))
	MtfMenu_Frame:Center()
	MtfMenu_Frame:SetDraggable(true)
	MtfMenu_Frame:SetDeleteOnClose(true)
	MtfMenu_Frame:SetDraggable(false)
	MtfMenu_Frame:ShowCloseButton(true)
	MtfMenu_Frame:MakePopup()
	MtfMenu_Frame.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0))
		draw.RoundedBox(2, 1, 1, w - 2, h - 2, Color(90, 90, 95))
	end
	
	local maininfo = vgui.Create("DLabel", MtfMenu_Frame)
	maininfo:SetText("Special Actions")
	maininfo:Dock(TOP)
	maininfo:SetFont("MTF_2Main")
	maininfo:SetContentAlignment(5)
	--maininfo:DockMargin(245, 8, 8, 175)
	maininfo:SetSize(0, 24)
	maininfo.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(0, 0, 0))
		draw.RoundedBox(2, 1, 1, w - 2, h - 2, Color(90, 90, 95))
	end

	for k,v in pairs(spa) do
		local button = vgui.Create("DButton", MtfMenu_Frame)
		button:SetText(v.text)
		button:Dock(TOP)
		button:SetFont("MTF_Main")
		button:SetContentAlignment(5)
		button:DockMargin(0, 5, 0, 0)
		button:SetSize(0, button_height)
		button.DoClick = function()
			RunSpecialAction(v)
			MtfMenu_Frame:Close()
		end
	end
end

local function remove_sa_menu()
	sa_menu_items = {}
	sa_menu_n_items = 0
	sa_menu_enabled = false
	sa_menu_selected_group = nil
end
remove_sa_menu()

-- 【=◈︿◈=】

local function cs16_buymenu_keybinds(ply, bind, pressed)
	if pressed and string.find(bind, "+zoom") then
		if sa_menu_enabled then
			remove_sa_menu()
		else
			sa_menu_items = {}
			for k,v in pairs(SPECIAL_ACTIONS) do
				if v.condition(LocalPlayer()) then
					if sa_menu_items[v.group] == nil then
						sa_menu_items[v.group] = {}
					end
					table.ForceInsert(sa_menu_items[v.group], v)
				end
			end
			sa_menu_n_items = table.Count(sa_menu_items)
			if table.Count(sa_menu_items) > 0 then
				sa_menu_enabled = true
			end
		end
		return true
	end


    if pressed and sa_menu_enabled and string.find(bind, "slot") then
        if string.find(bind, "slot0") then
			sa_menu_items = {}
            sa_menu_enabled = false
            return true
        end
		if sa_menu_selected_group == nil then
			local num = 1
			if table.Count(sa_menu_items) == 1 and sa_menu_items["null"] then
				for k,v in pairs(sa_menu_items["null"]) do
					if string.find(bind, "slot"..num) then
						RunSpecialAction(v)
						remove_sa_menu()
						return true
					end
					num = num + 1
				end
				return true
			end

			local num = 1
			for k,v in pairs(sa_menu_items) do
				if string.find(bind, "slot"..num) then
					sa_menu_selected_group = num
					return true
				end
				num = num + 1
			end
		else
			local num = 1
			for k,v in pairs(sa_menu_items) do
				if num == sa_menu_selected_group then
					local num2 = 1
					for k2,v2 in pairs(v) do
						if string.find(bind, "slot"..num2) then
							RunSpecialAction(v2)
							remove_sa_menu()
							return true
						end
						num2 = num2 + 1
					end
					return true
				end
				num = num + 1;
			end
			
		end
    end
end
hook.Add("PlayerBindPress", "hook_cs16_buymenu_keybinds", cs16_buymenu_keybinds)

hook.Add("HUDPaint", "BR_SpecialActionsMenu", function()
    if sa_menu_enabled then
		local buymenu_h = (5 + sa_menu_n_items) * 24
        local y_offset = ScrH() / 2.2

        draw.DrawText("Special Actions", "GH_BMenu_1", 8, y_offset, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

        local last_y = 48 + y_offset
		local i = 1
        for k,v in pairs(sa_menu_items) do
			local clr = Color(255,255,255,255)
			local clr2 = clr
			if sa_menu_selected_group != nil then
				clr2 = Color(255,255,255,50)
				clr = Color(255,255,255,50)
				if sa_menu_selected_group == i then
					clr2 = Color(255,255,255,255)
					clr = Color(255,255,0,255)
				end
			end

			local gap = ""
			if k != "null" and sa_group_names[k] then
				draw.DrawText(i .. ". " .. sa_group_names[k], "GH_BMenu_1", 8, last_y, clr, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				last_y = last_y + 24
				gap = "	"
			end

			local num = 1
			for k2,v2 in pairs(v) do
				draw.DrawText(gap .. num .. ". " .. v2.text, "GH_BMenu_1", 8, last_y, clr2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				last_y = last_y + 24
				num = num + 1
			end
			i = i + 1

			if gap != "" and i > 1 and i <= sa_menu_n_items then
				last_y = last_y + 24
			end
        end

		/*
        if buymenu_current_page != buy_menu_pages.main then
            draw.DrawText("9. Prev", "GH_BMenu_1", 8, y_offset + buymenu_h - 48, buymenu_color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        end
		*/

        draw.DrawText("0. Exit", "GH_BMenu_1", 8, last_y + 24, buymenu_color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
    end
end)

print("Gamemode loaded core/client/ui/menu_mtf.lua")