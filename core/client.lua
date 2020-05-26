local sx, sy = guiGetScreenSize()
local height = 15

function drawNameTag(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
	local x, y, z = getElementPosition(TheElement)
	local x2, y2, z2 = getCameraMatrix()
	local distance = distance or 20
	local height = height or 1

	if (isLineOfSightClear(x, y, z+2, x2, y2, z2, ...)) then
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
    local BoneX,BoneY,BoneZ = getPedBonePosition(TheElement, 21)
    local SBX,SBY = getScreenFromWorldPosition ( BoneX,BoneY,BoneZ )
    local textLength = dxGetTextWidth(text, size, font)
		if(sx) and (sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
        local tL, tH = dxGetTextSize(text, textLength, (size or 1)-(distanceBetweenPoints / distance), (size or 1)-(distanceBetweenPoints / distance), font, false)
        dxDrawText(tL .. " " .. tH, SBX+45, SBY+(tH*2), SBX, SBY, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "left", "center")
        dxDrawRectangle(SBX+40, SBY-(tH/2), 3, tH+2, tocolor(60 ,63, 208, 150))
        dxDrawRectangle(SBX+43, SBY-(tH/2), tL+7, tH+2, tocolor(0 ,0, 0, 120))
        --dxDrawText(text, SBX+46, SBY+3, SBX, SBY, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "left", "center")
      	dxDrawText(text, SBX+45, SBY+2, SBX, SBY, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "left", "center")
			end
		end
	end
end


addEventHandler("onClientRender", root,
      function()
        setTime(12, 00)
        local playerName = getPlayerName(getLocalPlayer())
        local players = playerCount
        local players = getElementsByType("player");
        local playerCount = #players;

        for i = 2, #players do

          setPlayerNametagShowing(players[i], false)
          drawNameTag(players[i], getPlayerName(players[i]), 1, 60, 230, 230, 230, 255, 1.5, "arial")
        end

        if playerCount < 2 then
          local textLength = dxGetTextWidth(playerName .. " / " .. playerCount .. " player online / MTA:SA 1.5.7*", 1, "default")
          dxDrawText(playerName .. " / " .. playerCount .. " player online /", sx - textLength, sy - height, _, _, tocolor(255, 255, 255, 120), 1, "default")
        else
          local textLength = dxGetTextWidth(playerName .. " / " .. playerCount .. " players online / MTA:SA 1.5.7*", 1, "default")
          dxDrawText(playerName .. " / " .. playerCount .. " players online /", sx - textLength, sy - height, _, _, tocolor(255, 255, 255, 120), 1, "default")
        end


        --dxDrawRectangle(0, sy - height, sx, height, tocolor(0, 0, 0, 150))
      end
)
