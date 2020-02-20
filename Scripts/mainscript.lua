local RE = stateMainForm:GetChildChecked( "RewardsExchange", false ):GetChildChecked( "MainPanel", false ):GetChildChecked( "List", false )
RE:SetOnShowNotification( true )
local qualitytable = {
["ITEM_QUALITY_COMMON"] = 0.149,
["ITEM_QUALITY_UNCOMMON"] = 1.125,
["ITEM_QUALITY_RARE"] = 1.753,
["ITEM_QUALITY_EPIC"] = 1.0,
["ITEM_QUALITY_LEGENDARY"] = 0.824,
["ITEM_QUALITY_RELIC"] = 1.129,
}

function SetPos(wt,posX,sizeX,posY,sizeY,highPosX,highPosY,alignX, alignY, addchild)
  if wt then
    local p = wt:GetPlacementPlain()
    if posX then p.posX = posX end
    if sizeX then p.sizeX = sizeX end
    if posY then p.posY = posY end
    if sizeY then p.sizeY = sizeY end
    if highPosX then p.highPosX = highPosX end
    if highPosY then p.highPosY = highPosY end
	if alignX then p.alignX = alignX end
	if alignY then p.alignY = alignY end
    wt:SetPlacementPlain(p) 
  end
  if addchild then addchild = addchild:AddChild( wt ) end
end

function GetQuality(color)
for q, v in pairs(qualitytable) do
	if color == v then
return q
		end
	end
end

function ExchangeStart(params)
if params and params.widget:GetName() == "List" then
local childn = RE:GetNamedChildren()
for _, wg in pairs(childn) do
	if string.find(wg:GetName(), "SlotFrame") and wg:IsVisible() then
	local wtquality = wg:GetChildChecked( "Line", false ):GetChildChecked( "Icon", false ):GetChildChecked( "Quality", false )
	local wtprice = wg:GetChildChecked( "Line", false ):GetChildChecked( "Price", false ):GetChildChecked( "Label", false )
	local wgt = wg:GetChildChecked( "Line", false ):GetChildChecked( "Name", false )
	local posprice = wg:GetChildChecked( "Line", false ):GetChildChecked( "Price", false )
	SetPos(posprice,0,200,0,30,230,0,WIDGET_ALIGN_HIGH, WIDGET_ALIGN_CENTER)
	if string.find(userMods.FromWString(common.ExtractWStringFromValuedText(wgt:GetValuedText())), GTL('Name')) then
			local wgtCalculate = wg:GetChildChecked( "Line", false ):GetChildChecked( "Price", false ):GetChildChecked( "Label", false )
			local dcalctxt = mainForm:CreateWidgetByDesc(wgtCalculate:GetWidgetDesc())
			dcalctxt:SetName( "Text"..wg:GetName() )
			dcalctxt:SetFormat(userMods.ToWString("<html><body alignx='left' outline='1' ><r name='value'/> </body></html>"))
			SetPos(dcalctxt,580,100,10,30,0,0,WIDGET_ALIGN_LOW, WIDGET_ALIGN_LOW, wg)
			local color = wtquality:GetForegroundColor()
			local quality = GetQuality(tonumber(userMods.FromWString(common.FormatFloat( color.r+color.b, "%.3f" ))))
			local exprice = tostring(userMods.FromWString(common.ExtractWStringFromValuedText(wtprice:GetValuedText())))
			local price = string.sub(exprice, 1, #exprice-1)
				if quality == "ITEM_QUALITY_COMMON" then
				local pricet = userMods.FromWString(common.FormatFloat( price/COMMON_1, "%.1f" )).." | "..userMods.FromWString(common.FormatFloat( price/COMMON_2, "%.1f" )).." | "..userMods.FromWString(common.FormatFloat( price/COMMON_3, "%.1f" ))
				dcalctxt:SetVal("value", pricet)
				elseif quality == "ITEM_QUALITY_UNCOMMON" then
				local pricet = userMods.FromWString(common.FormatFloat( price/UNCOMMON_1, "%.1f" )).." | "..userMods.FromWString(common.FormatFloat( price/UNCOMMON_2, "%.1f" )).." | "..userMods.FromWString(common.FormatFloat( price/UNCOMMON_3, "%.1f" ))
				dcalctxt:SetVal("value", pricet)
				elseif quality == "ITEM_QUALITY_RARE" then
				local pricet = userMods.FromWString(common.FormatFloat( price/RARE_1, "%.1f" )).." | "..userMods.FromWString(common.FormatFloat( price/RARE_2, "%.1f" )).." | "..userMods.FromWString(common.FormatFloat( price/RARE_3, "%.1f" ))
				dcalctxt:SetVal("value", pricet)
				elseif quality == "ITEM_QUALITY_EPIC" then
				local pricet = userMods.FromWString(common.FormatFloat( price/EPIC_1, "%.1f" )).." | "..userMods.FromWString(common.FormatFloat( price/EPIC_2, "%.1f" )).." | "..userMods.FromWString(common.FormatFloat( price/EPIC_3, "%.1f" ))
				dcalctxt:SetVal("value", pricet)
				elseif quality == "ITEM_QUALITY_LEGENDARY" then
				local pricet = userMods.FromWString(common.FormatFloat( price/LEGENDARY_1, "%.1f" )).." | "..userMods.FromWString(common.FormatFloat( price/LEGENDARY_2, "%.1f" )).." | "..userMods.FromWString(common.FormatFloat( price/LEGENDARY_3, "%.1f" ))
				dcalctxt:SetVal("value", pricet)
				elseif quality == "ITEM_QUALITY_RELIC" then
				local pricet = userMods.FromWString(common.FormatFloat( price/RELIC_1, "%.1f" )).." | "..userMods.FromWString(common.FormatFloat( price/RELIC_2, "%.1f" )).." | "..userMods.FromWString(common.FormatFloat( price/RELIC_3, "%.1f" ))
				dcalctxt:SetVal("value", pricet)
					end
				end		
			end
		end
	end
end

function destroywt()
local delchild = RE:GetNamedChildren()
for _, wgtr in pairs(delchild) do
	if string.find(wgtr:GetName(), "SlotFrame") and wgtr:IsVisible() then
	local childtxt = wgtr:GetNamedChildren()
	for _, wttxt in pairs(childtxt) do
		if string.find(wttxt:GetName(), "Text") and wttxt:IsVisible() then
				wttxt:DestroyWidget()
				end
			end
		end
	end
end

function update()
if RE:IsVisible() then
	destroywt()
	local params = {widget=RE,}
	ExchangeStart(params)
	end
end

function Init()
common.RegisterEventHandler( ExchangeStart, "EVENT_WIDGET_SHOW_CHANGED")
common.RegisterEventHandler( update, "EVENT_SECOND_TIMER")
end

if (avatar.IsExist()) then Init()
else common.RegisterEventHandler(Init, "EVENT_AVATAR_CREATED")	
end