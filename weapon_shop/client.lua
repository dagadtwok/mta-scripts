markerposX = -2184
markerposY = 640
markerposZ = 47

weaponshopmarker = createMarker(markerposX, markerposY, markerposZ, "cylinder", 3, 255, 50, 50, 50)
salebg =  dxCreateTexture("images/sale.png")
sale2bg =  dxCreateTexture("images/sale2.png")
weaponsbg =  dxCreateTexture("images/weapons.png")
vehiclesbg =  dxCreateTexture("images/vehicles.png")

local shopmenu = 1
local atime = 0
local timer = 0
local salesbgc = 0
local salesbgalpha = 255
local salesFadeIn = false

function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
	local x, y, z = getElementPosition(TheElement)
	local x2, y2, z2 = getCameraMatrix()
	local distance = distance or 20
	local height = height or 1

	if (isLineOfSightClear(x, y, z+2, x2, y2, z2, ...)) then
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
		if(sx) and (sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
				local textLenght = dxGetTextWidth(text, size , font)
				dxDrawRectangle(sx -(textLenght/2)-15, sy -15, textLenght+30, 35, tocolor(0, 0, 0, 180))
				dxDrawRectangle(sx -(textLenght/2)-15, sy -18, textLenght+30, 3, tocolor(255, 255, 255, 180))
				dxDrawRectangle(sx -(textLenght/2)-15, sy + 20, textLenght+30, 3, tocolor(255, 255, 255, 180))
				dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), size, font or "arial", "center", "center")
			end
		end
	end
end


addEventHandler( "onClientRender", root,
    function()
		dxDrawTextOnElement(weaponshopmarker, "Black Market", 2.5, 17, 255, 255, 255, 255, 1.6, "pricedown", false, false, false, false, true)
		end
)

addEventHandler( "onClientMarkerHit", root,
    function(hitplayer)
		if hitplayer == getLocalPlayer() and source == weaponshopmarker then
				entershop()
		end

	end
)
function exitshop()
	setCameraTarget(getLocalPlayer())
	shopmenu = 0
	showCursor(false)
	triggerEvent("showHud", root)
end

function entershop()
	triggerEvent("hideHud", root)
	setCameraMatrix(-2138.02734, 709.99939, 69.41406, -2129.58447, 681.09216, 78.15553)
	showCursor(true)
	shopmenu = 1
end


addEventHandler( "onClientRender", root,
    function()
			local time = getRealTime()
			if (shopmenu == 1) then
				showCursor(true)
				local saleselectalpha = 0
				local weaponsselectalpha = 0
				local vehiclesselectalpha = 0

				local mx, my = getCursorPosition()
				local sx, sy = guiGetScreenSize()

				--sx = 1024
				--sy = 768

				mx = mx * sx
				my = my * sy

				if atime ~= time.second then
					timer = timer + 1
					atime = time.second
				end

				dxDrawText(timer .. " " .. salesbgc, 50, 50)
				if timer > 6 then
					salesFadeIn = false
					timer = 0
				end

				if salesFadeIn then
					if salesbgalpha < 255 then
						 salesbgalpha = salesbgalpha + 5
					end
				else
					if salesbgalpha > 0 then
						 salesbgalpha = salesbgalpha - 5
					 else
						 if salesbgc ~= 1 then
	 						salesbgc = salesbgc + 1
	 					else
	 						salesbgc = 0
	 					end
						 salesFadeIn = true
					end
				end
				if mx > 150 and mx < 150 +sx/2 and my > 150 and my < 150 + 200 then
						saleselectalpha = 250
				end
				if mx > sx/2 + 155 and mx < sx/2 + 155 + sx - sx/2 - 150 - 155 and my > 150 and my < 150 + 200 then
						weaponsselectalpha = 250
				end
				if mx > 150 and mx < 150 + sx - 300 and my > 355 and my < 355 + 300 then
						vehiclesselectalpha = 250
				end

				dxDrawRectangle(sx, 0, 15, sy)
				dxDrawRectangle(0, sy, sx, 15)

				--dxDrawRectangle(150, 50, sx - 300, 700, tocolor(0, 0, 0, 100))

				dxDrawRectangle(150, 50, sx - 300, sy * 0.08, tocolor(0, 0, 0, 200))

				dxDrawText("Black Market", 155, sy * 0.08-15, _, _, tocolor(250, 250, 250, 255), 2, "pricedown")

				dxDrawRectangle(150-3, 150-3, sx/2+6, 200+6, tocolor(250, 250, 250, saleselectalpha))
				dxDrawRectangle(150, 150, sx/2, 200, tocolor(0, 0, 0, 200))
				--dxDrawImage(150+1, 150+1, sx/2-2, 200-2, salebg)
				if salesbgc == 0 then
					dxDrawImageSection(150+1, 150+1, sx/2-2, 200-2, 150, 150, sx/2, 200, sale2bg, 0, 0, 0, tocolor(255, 255, 255, salesbgalpha))
				else
					dxDrawImageSection(150+1, 150+1, sx/2-2, 200-2, 150, 150, sx/2, 200, salebg, 0, 0, 0, tocolor(255, 255, 255, salesbgalpha))
				end
				dxDrawText("On Sale", (150+sx/2) - dxGetTextWidth("On Sale", 1.5, "bankgothic"), 310, _, _, tocolor(250, 250, 250, 255), 1.5, "bankgothic")

				dxDrawRectangle(sx/2 + 155-3, 150-3, sx - sx/2 - 150 - 155+6, 200+6, tocolor(250, 250, 250, weaponsselectalpha))
				dxDrawRectangle(sx/2 + 155, 150, sx - sx/2 - 150 - 155, 200, tocolor(0, 0, 0, 200))
				--dxDrawImage(sx/2 + 155, 150, sx - sx/2 - 150 - 155, 200, weaponsbg)
				dxDrawImageSection(sx/2 + 155+1, 150+1, sx - sx/2 - 150 - 155-2, 200-2, 150, 150, sx/2, 250, weaponsbg)
				dxDrawText("Weapons", sx/2+155 + sx - sx/2 - 150 - 155 - dxGetTextWidth("Weapons", 1.5, "bankgothic"), 310, _, _, tocolor(250, 250, 250, 255), 1.5, "bankgothic")

				dxDrawRectangle(150-3, 355-3, sx - 300+6, 300+6, tocolor(250, 250, 250, vehiclesselectalpha))
				dxDrawRectangle(150, 355, sx - 300, 300, tocolor(0, 0, 0, 200))
			--dxDrawImage(sx/2 + 155, 150, sx - sx/2 - 150 - 155, 200, weaponsbg)
				dxDrawImageSection(150+1, 355+1, sx - 300-2, 300-2,150, 150, sx/2, 200, vehiclesbg)
				dxDrawText("Vehicles", sx - 150 - dxGetTextWidth("Vehicles", 1.5, "bankgothic"), 615, _, _, tocolor(250, 250, 250, 255), 1.5, "bankgothic")

				dxDrawRectangle(sx - dxGetTextWidth("Press Backspace to quit", 1, "bankgothic") - 15, sy - 40,dxGetTextWidth("Press Backpsace to quit", 1, "bankgothic") + 5, 30, tocolor(0, 0, 0, 200))
				dxDrawText("Press Backspace to quit", sx/2+150 + sx - sx/2 - 165 - dxGetTextWidth("Press Backspace to quit", 1, "bankgothic"), sy - 40, _, _, tocolor(250, 250, 250, 255), 1, "bankgothic")
			end
		end
)
addCommandHandler("closeShop", exitshop)


bindKey("Backspace", "down",
	function()
		if shopmenu == 1 then
			exitshop()
		end
	end
)

bindKey("mouse1", "down",
	function()

		if shopmenu == 1 then
			local mx, my = getCursorPosition()
			local sx, sy = guiGetScreenSize()

			--sx = 1024
			--sy = 768

			mx = mx * sx
			my = my * sy
			if mx > 150 and mx < 150 +sx/2 and my > 150 and my < 150 + 200 then
					triggerEvent("sendNotification", root, "1", "On Sale")
			end
			if mx > sx/2 + 155 and mx < sx/2 + 155 + sx - sx/2 - 150 - 155 and my > 150 and my < 150 + 200 then
					triggerEvent("sendNotification", root, "1", "Weapons")
			end
			if mx > 150 and mx < 150 + sx - 300 and my > 355 and my < 355 + 300 then
					triggerEvent("sendNotification", root, "1", "Vehicles")
			end
		end
	end
)
