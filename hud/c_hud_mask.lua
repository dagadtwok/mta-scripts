-- Based on ccw's Hud mask shader // https://wiki.multitheftauto.com/wiki/Shader_examples
local zoom = 10
local actuallzoom = 0
local radarpos = 0
local aradarpos = 0
local radarw = 0
local radarh = 0
local aradarw = 0
local aradarh = 0
local aradaralpha = 0;

local timer = 0;
local timer2 = 0;

hideHud = 0

crosshairR = 150
crosshairG = 255
crosshairB = 30

sx, sy = guiGetScreenSize()

local dot = dxCreateTexture(1,1)
local white = tocolor(255,255,255,255)
function dxDrawRectangle3D(x,y,z,w,h,c,r,...)
        local lx, ly, lz = x+w, y+h, (z+tonumber(r or 0)) or z
	return dxDrawMaterialLine3D(x,y,z, lx, ly, lz, dot, h, c or white, ...)
end

function dxDrawImage3D( x, y, z, width, height, material, color, rotation, ... )
    return dxDrawMaterialLine3D( x, y, z, x + width, y + height, z + tonumber( rotation or 0 ), material, height, color or 0xFFFFFFFF, ... )
end

function blackScreen()
	dxDrawRectangle(0, 0, sx, sy, tocolor(0, 0, 0, 255))
	local text = "Your screen's resolution isn't supported."
	dxDrawText(text, sx/2, sy/2, _, _, tocolor(255, 255, 255, 255), 1.0, "bankgothic", "center")
end


function setup()
    hudMaskShader = dxCreateShader("hud_mask.fx")
	radarTexture = dxCreateTexture("images/radar.jpg")
	maskTexture2 = dxCreateTexture("images/sept_mask.png")
	radarPlayer = dxCreateTexture("images/player.png")

	bAllValid = hudMaskShader and radarTexture and maskTexture2

	if not bAllValid then
		outputChatBox( "Could not create some things. Please use debugscript 3" )
	else
		dxSetShaderValue( hudMaskShader, "sPicTexture", radarTexture )
	end

	--resemu()

	setPlayerHudComponentVisible("all", false)

	if sx < 1024 then
		addEventHandler("onClientRender", root, blackScreen);
	end

	local lNode = xmlLoadFile("settings.xml")
	if lNode then
		local xmlFinder = xmlFindChild(lNode, "R", 0)
		crosshairR = xmlNodeGetValue(xmlFinder)
		xmlFinder = xmlFindChild(lNode, "G", 0)
		crosshairG = xmlNodeGetValue(xmlFinder)
		xmlFinder = xmlFindChild(lNode, "B", 0)
		crosshairB = xmlNodeGetValue(xmlFinder)
		xmlUnloadFile(lNode)
	else
		local rNode = xmlCreateFile("settings.xml","crosshair")
		local cNode = xmlCreateChild(rNode, "R")
		local marker = xmlFindChild(rNode, "R", 0)
		xmlNodeSetValue(marker, crosshairR)
		local cNode = xmlCreateChild(rNode, "G")
		marker = xmlFindChild(rNode, "G", 0)
		xmlNodeSetValue(marker, crosshairG)
		local cNode = xmlCreateChild(rNode, "B")
		marker = xmlFindChild(rNode, "B", 0)
		xmlNodeSetValue(marker, crosshairB)
		xmlSaveFile(rNode)
		xmlUnloadFile(rNode)
	end

end


csx = sx/2 + (sx*1.03-sx)
csy = sy/2 - (sy*1.1-sy)-1

addEventHandler( "onClientRender", root,
    function()
      if hideHud == 0 then
		local weapon = getPedWeapon(getLocalPlayer ( ))
		if getControlState("aim_weapon") and weapon ~= 0 then
			dxDrawRectangle(csx-6, csy-1, 14, 4, tocolor(0, 0, 0, 255))
			dxDrawRectangle(csx-5, csy, 12, 2, tocolor(crosshairR, crosshairG, crosshairB, 255))
			dxDrawRectangle(csx-1, csy-6, 4, 5, tocolor(0, 0, 0, 255))
			dxDrawRectangle(csx-1, csy+3, 4, 5, tocolor(0, 0, 0, 255))
			dxDrawRectangle(csx, csy-5, 2, 12, tocolor(crosshairR, crosshairG, crosshairB, 255))
		end

		if not bAllValid then return end

		dxSetShaderValue( hudMaskShader, "sMaskTexture", maskTexture2 )
		local x,y = getElementPosition(localPlayer)
		x = ( x ) / 6000
		y = ( y ) / -6000
		dxSetShaderValue( hudMaskShader, "gUVPosition", x,y )

		local _,_,camrot = getElementRotation( getCamera() )

		dxSetShaderValue( hudMaskShader, "gUVScale", 1/actuallzoom, 1/actuallzoom )


		dxSetShaderValue( hudMaskShader, "gUVRotAngle", math.rad(-camrot) )



		local radaralpha = 0

		if zoom == 10 then
			radarpos = sy - 300
			radarw  = 300
			radarh = 300
			radaralpha = 180
			if aradaralpha > radaralpha then
				aradaralpha = aradaralpha - 5
			end
		else
			timer = 0
			timer2 = 0
			radarpos = sy - 600
			radarw  = 600
			radarh = 600
			radaralpha = 255
		end

			if actuallzoom < zoom then
				actuallzoom = actuallzoom + 1
			elseif actuallzoom > zoom then
				actuallzoom = actuallzoom - 1
			end

		if aradarw < radarw then
			aradarw = aradarw + 50
		end
		if aradarpos < radarpos then
			aradarpos = radarpos
		end

		if aradarh < radarh then
			aradarh = aradarh + 50
		end

		if aradaralpha < radaralpha then
			aradaralpha = aradaralpha + 5
		end

		if aradarw > radarw then
			aradarw = radarw
		end
		if aradarh > radarh then
			aradarh = radarh
		end
		if aradarh > radarpos then
			aradarpos = aradarpos - 50
		end

		dxDrawImage( 0, aradarpos, aradarw, aradarh, hudMaskShader, 0,0,0, tocolor(255,255,255,aradaralpha) )

		local rot = getPedRotation(getLocalPlayer ( ))
		rot = camrot - rot
		dxDrawImage(aradarw/2-5, aradarpos+(aradarh/2)-5, 10, 10, radarPlayer, rot, 0, 0, tocolor(255, 255, 255, aradaralpha))
    end
  end
)

local aareapos = 0
local atime = 0

local azone = "";
addEventHandler( "onClientRender", root,
    function()
      if hideHud == 0 then
		local time = getRealTime()
		local areapos = 0;
		local x, y, z = getElementPosition(getLocalPlayer ( ))
		local cityname = getZoneName(x, y, z, true)
		local zonename = getZoneName(x, y, z)
		local locationtext
		--local zonelenght = dxGetTextWidth(zonename, 1.0, "sans")
		--local citylenght = dxGetTextWidth(cityname, 1.0, "sans")


		if cityname == zonename then
			locationtext = zonename
		else
			locationtext = zonename .. ", " .. cityname
		end

		local locationtextLenght = dxGetTextWidth(locationtext, 1.0, "sans")

		if timer > 3 then
		areapos = 0
		else
		areapos = locationtextLenght + 13
		end

		if aareapos < areapos then
			aareapos = aareapos + 10
		end
		if aareapos > areapos then
			aareapos = aareapos - 10
		end

		if atime == time.second then
		else
			timer = timer + 1
			timer2 = timer2 + 1
			atime = time.second
		end

		if azone == zonename then
		else
			timer = 0
			azone = zonename
		end

		dxDrawRectangle(0 , aradarpos - 10, aareapos, 20, tocolor(0, 0, 0 ,150))
		dxDrawText( locationtext, 3, aradarpos - 10, aareapos, sy, tocolor(255, 255, 255, 255), _, "sans", _, _, true)
  end
    end
)

function findrotation (x,y,rz,dist,rot)
			local x = x+dist*math.cos(math.rad(rz+rot))
			local y = y+dist*math.sin(math.rad(rz+rot))
			return x,y
end


local hudalphafont = 0
local hudalpha = 0
local amoney = 0
local ahealth = 0
local aweapon = 0

addEventHandler( "onClientRender", root,
    function()
      if hideHud == 0 then
		local BoneX,BoneY,BoneZ = getPedBonePosition(getLocalPlayer(), 3)
		local SBX,SBY = getScreenFromWorldPosition ( BoneX,BoneY,BoneZ )
		local pName = getPlayerName(getLocalPlayer())
		local health = getElementHealth(getLocalPlayer())
		local money = getPlayerMoney(getLocalPlayer ( ))
		local weapon = getPedWeapon(getLocalPlayer ( ))
		local pNameLenght = dxGetTextWidth(pName, 1.2, "default-bold")
		local moneyLenght = dxGetTextWidth("$ " .. money, 1.2, "default-bold")

		if amoney == money then
		else
			timer2 = 0
			amoney = money
		end
		if aweapon == weapon then
		else
			timer2 = 0
			aweapon = weapon
		end

		if ahealth == health then
		else
			timer2 = 0
			if ahealth > health then
				ahealth = ahealth - 5
			else
				ahealth = health
			end
		end


		if timer2 > 10 then
			if hudalpha > 0 then
				hudalpha = hudalpha - 5
			end
			if hudalphafont > 0 then
				hudalphafont = hudalphafont - 5
			end
		else
			hudalpha = 120
			hudalphafont = 255
		end

		if SBX and SBY then

			dxDrawRectangle(SBX + 100, SBY-55, pNameLenght+20, 30,tocolor(0 ,0, 0,hudalpha))
			dxDrawRectangle(SBX + 100, SBY-58, pNameLenght+20, 3,tocolor(60 ,63, 208,hudalpha))

			dxDrawText(pName, SBX + 110, SBY-50, _, _, tocolor(255, 255, 255, hudalphafont), 1.2, "default-bold")

			dxDrawRectangle(SBX + 100 + pNameLenght + 20 + 5, SBY-58, moneyLenght + 10, 3,tocolor(60 ,63, 208,hudalpha))
			dxDrawRectangle(SBX + 100 + pNameLenght + 20 + 5, SBY-55, moneyLenght + 10, 30,tocolor(0 ,0, 0,hudalpha))

			dxDrawText("$ " .. money, SBX + 130 + pNameLenght, SBY-50, _, _, tocolor(255, 255, 255, hudalphafont), 1.2, "default-bold")

			dxDrawRectangle(SBX + 100, SBY-20, pNameLenght + 20 + 5 + moneyLenght + 10, 12, tocolor(0 ,0, 0,hudalpha))
			dxDrawRectangle(SBX + 103, SBY-17, (pNameLenght + 20 + 5 + moneyLenght + 4) * (ahealth/100), 6, tocolor(255 ,255, 255,hudalpha))

			dxDrawImage(SBX + 100 + ((pNameLenght + 20 + 5 + moneyLenght + 4 - 120)/2), SBY, 120, 50, "images/weapons/".. weapon ..".png", 0, 0, 0,tocolor(255, 255, 255, hudalphafont))
		end
end
    end
)

function viewmap()
	if zoom == 10 then
		zoom = 3
	else
		zoom = 10
	end
end
function showhud()
	timer2 = 0
end


function resemu()
sx = 1024
sy = 768
rsx, rsy = guiGetScreenSize()
end


local cEisOpen = false
local cEMove = false
local cEX = sx/2-200
local cEY = sy/2-100
function crosshairEditor()
	if cEisOpen then
		cEisOpen = false
		showCursor(false)
		saveData()
	else
		cEisOpen = true
		showCursor(true)
	end
end


addEventHandler( "onClientRender", root,
	function ()
if hideHud == 0 then
	if cEisOpen then
		mx, my = getCursorPosition()
		mx = sx * mx
		my = sy * my
		dxDrawRectangle(cEX, cEY, 400, 260, tocolor(0, 0, 0, 200))
		dxDrawRectangle(cEX, cEY, 400, 20, tocolor(0, 0, 0, 200))
		dxDrawRectangle(cEX + 50, cEY + 30, 300, 100, tocolor(170, 221, 221, 255))
		dxDrawRectangle(csx-6, csy-1, 14, 4, tocolor(0, 0, 0, 255))
		dxDrawText("Crosshair Editor", cEX + 3, cEY+1, _, _, tocolor(255, 255, 255, 255))
		dxDrawText("X", cEX + 390, cEY+1, _, _, tocolor(255, 255, 255, 255))

			dxDrawRectangle(cEX + 200 - 33, cEY + 70 - 3, 66, 26, tocolor(0, 0, 0, 255))
			dxDrawRectangle(cEX + 200 - 30, cEY + 70, 60, 20, tocolor(crosshairR, crosshairG, crosshairB, 255))
			dxDrawRectangle(cEX + 200 - 13, cEY + 70 - 23, 26, 20, tocolor(0, 0, 0, 255))
			dxDrawRectangle(cEX + 200 - 13, cEY + 70 + 20, 26, 23, tocolor(0, 0, 0, 255))
			dxDrawRectangle(cEX + 200 - 10, cEY + 70 - 20, 20, 60, tocolor(crosshairR, crosshairG, crosshairB, 255))

			dxDrawRectangle(cEX + 100, cEY + 150, 250, 20, tocolor(30, 30, 30, 255))
			dxDrawRectangle(cEX + 100, cEY + 180, 250, 20, tocolor(30, 30, 30, 255))
			dxDrawRectangle(cEX + 100, cEY + 210, 250, 20, tocolor(30, 30, 30, 255))

			if (mx > cEX + 100 and mx < cEX + 350) then
				if (my > cEY + 150 and my < cEY + 170) then
					dxDrawRectangle(cEX + 100, cEY + 150, mx-(cEX+100), 20, tocolor(105, 128, 128, 255))
				end
				if (my > cEY + 180 and my < cEY + 200) then
					dxDrawRectangle(cEX + 100, cEY + 180, mx-(cEX+100), 20, tocolor(105, 128, 128, 255))
				end
				if (my > cEY + 210 and my < cEY + 230) then
					dxDrawRectangle(cEX + 100, cEY + 210, mx-(cEX+100), 20, tocolor(105, 128, 128, 255))
				end
			end

			dxDrawText("Red", cEX + 50, cEY + 150, _, _, tocolor(255, 255, 255, 255), 1.2, "default")

			dxDrawRectangle(cEX + 100, cEY + 150, 250*(crosshairR/255), 20, tocolor(139, 165, 165, 255))

			dxDrawText("Green", cEX + 50, cEY + 180, _, _, tocolor(255, 255, 255, 255), 1.2, "default")

			dxDrawRectangle(cEX + 100, cEY + 180, 250*(crosshairG/255), 20, tocolor(139, 165, 165, 255))

			dxDrawText("Blue", cEX + 50, cEY + 210, _, _, tocolor(255, 255, 255, 255), 1.2, "default")

			dxDrawRectangle(cEX + 100, cEY + 210, 250*(crosshairB/255), 20, tocolor(139, 165, 165, 255))
end
	end
end
)

bindKey("mouse1", "both",
	function()
	if cEisOpen then
			if (mx > cEX + 100 and mx < cEX + 350) then
					if (my > cEY + 150 and my < cEY + 170) then
						crosshairR = 255*((mx-(cEX+100))/250)
					end
					if (my > cEY + 180 and my < cEY + 200) then
						crosshairG = 255*((mx-(cEX+100))/250)
					end
					if (my > cEY + 210 and my < cEY + 230) then
						crosshairB = 255*((mx-(cEX+100))/250)
					end
			end
			if (mx > cEX + 387 and mx < cEX + 400 and my > cEY and my < cEY + 20) then
				cEisOpen = false
				showCursor(false)
				saveData()
			end
		end
	end
)


function saveData()
	local configFile = xmlLoadFile("settings.xml")
	local marker = xmlFindChild(configFile, "R", 0)
	xmlNodeSetValue(marker, crosshairR)
	marker = xmlFindChild(configFile, "G", 0)
	xmlNodeSetValue(marker, crosshairG)
	marker = xmlFindChild(configFile, "B", 0)
	xmlNodeSetValue(marker, crosshairB)
	xmlSaveFile(configFile)
	xmlUnloadFile(configFile)
end
bindKey("TAB", "both", viewmap)

bindKey("Z", "down", showhud)

addCommandHandler("crosshair", crosshairEditor)

setup()

function hideHudElements()
  hideHud = 1
  aradaralpha = 0
  timer2 = 0
  timer = 0
end
function showHudElements()
  hideHud = 0
end

addEvent("hideHud", true)
addEventHandler("hideHud", root, hideHudElements)
addEvent("showHud", true)
addEventHandler("showHud", root, showHudElements)
