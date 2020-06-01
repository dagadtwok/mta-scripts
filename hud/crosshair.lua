local sx, sy = guiGetScreenSize()

csx = sx/2 + (sx*1.03-sx)
csy = sy/2 - (sy*1.1-sy)-1

crosshairR = 150
crosshairG = 255
crosshairB = 30

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


function configSetup()
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

addEventHandler( "onClientRender", root,
function ()
  if hideHud == 0 then

    local weapon = getPedWeapon(getLocalPlayer ( ))
    if getControlState("aim_weapon") then
      if weapon ~= 0 and weapon ~= 35 and weapon ~= 45 and weapon ~= 1 and weapon ~= 9 then
        dxDrawRectangle(csx-6, csy-1, 14, 4, tocolor(0, 0, 0, 255))
        dxDrawRectangle(csx-5, csy, 12, 2, tocolor(crosshairR, crosshairG, crosshairB, 255))
        dxDrawRectangle(csx-1, csy-6, 4, 5, tocolor(0, 0, 0, 255))
        dxDrawRectangle(csx-1, csy+3, 4, 5, tocolor(0, 0, 0, 255))
        dxDrawRectangle(csx, csy-5, 2, 12, tocolor(crosshairR, crosshairG, crosshairB, 255))
      elseif weapon == 35 then
        dxDrawRectangle(sx/2 - (sx*1.05-sx), sy/2-(sy*1.1-sy), (sx*1.05-sx), 10, tocolor(crosshairR, crosshairG, crosshairB, 255))
        dxDrawRectangle(sx/2 - (sx*1.05-sx), sy/2-(sy*1.1-sy), 10, (sy*1.05-sy), tocolor(crosshairR, crosshairG, crosshairB, 255))

        dxDrawRectangle(sx/2 - (sx*1.05-sx), sy/2+(sy*1.1-sy), (sx*1.05-sx), 10, tocolor(crosshairR, crosshairG, crosshairB, 255))
        dxDrawRectangle(sx/2 - (sx*1.05-sx), sy/2+(sy*1.1-sy), 10, -(sy*1.05-sy), tocolor(crosshairR, crosshairG, crosshairB, 255))

        dxDrawRectangle(sx/2 + (sx*1.05-sx), sy/2-(sy*1.1-sy), (sx*1.05-sx), 10, tocolor(crosshairR, crosshairG, crosshairB, 255))
        dxDrawRectangle(sx/2 + ((sx*1.05-sx)*2), sy/2-(sy*1.1-sy), 10, (sy*1.05-sy), tocolor(crosshairR, crosshairG, crosshairB, 255))

        dxDrawRectangle(sx/2 + ((sx*1.05-sx)*2), sy/2+(sy*1.1-sy)+10, 10, -(sy*1.05-sy)-10, tocolor(crosshairR, crosshairG, crosshairB, 255))
        dxDrawRectangle(sx/2 + (sx*1.05-sx), sy/2+(sy*1.1-sy), (sx*1.05-sx), 10, tocolor(crosshairR, crosshairG, crosshairB, 255))
      end
    end

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


      if (mx > cEX + 100 and mx < cEX + 100 + 250*(crosshairR/255)) then
        if (my > cEY + 150 and my < cEY + 170) then
          dxDrawRectangle(cEX + 100 + mx-(cEX+100), cEY + 150, 250*(crosshairR/255)-(mx-(cEX+100)), 20, tocolor(105, 128, 128, 255))
        end
      end
      if (mx > cEX + 100 and mx < cEX + 100 + 250*(crosshairG/255)) then
        if (my > cEY + 180 and my < cEY + 200) then
          dxDrawRectangle(cEX + 100 + mx-(cEX+100), cEY + 180, 250*(crosshairG/255)-(mx-(cEX+100)), 20, tocolor(105, 128, 128, 255))
        end
      end
      if (mx > cEX + 100 and mx < cEX + 100 + 250*(crosshairB/255)) then
        if (my > cEY + 210 and my < cEY + 230) then
          dxDrawRectangle(cEX + 100 + mx-(cEX+100), cEY + 210, 250*(crosshairB/255)-(mx-(cEX+100)), 20, tocolor(105, 128, 128, 255))
        end
      end
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


addCommandHandler("crosshair", crosshairEditor)

configSetup()
