windows = {}
local windowsX = {}
local windowsY = {}
local windowsW = {}
local windowsH = {}

function roundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
	if (x and y and w and h) then
		if (not borderColor) then
			borderColor = tocolor(0, 0, 0, 200);
		end
		if (not bgColor) then
			bgColor = borderColor;
		end
		dxDrawRectangle(x, y, w, h, bgColor, postGUI);
		dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI);
		dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI);
		dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI);
		dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI);
	end
end

addEventHandler("onClientRender", root,
function()
  for i = 1, #windows do
    --dxDrawText(windows[i], 50, 50+(10*i))
    --dxDrawText(windowsX[i], 150, 50+(10*i))
    --dxDrawText(windowsY[i], 200, 50+(10*i))
    --dxDrawText(windowsW[i], 250, 50+(10*i))
    --dxDrawText(windowsH[i], 300, 50+(10*i))
    roundedRectangle(windowsX[i], windowsY[i], windowsW[i], windowsH[i], tocolor(15, 15, 15, 220), tocolor(15, 15, 15, 220), false)
    dxDrawRectangle(windowsX[i], windowsY[i], windowsW[i], 20, tocolor(0, 0, 0, 255));
    dxDrawRectangle(windowsX[i] + 2, windowsY[i] - 1, windowsW[i] - 4, 1, tocolor(0, 0, 0, 255));
    dxDrawText(windows[i], windowsX[i], windowsY[i], windowsX[i]+windowsW[i], 20, tocolor(255, 255, 255, 255), 1, "default", "center")
    dxDrawText("X", windowsX[i], windowsY[i], windowsX[i]+windowsW[i], 20, tocolor(255, 255, 255, 255), 1, "default", "right")
  end
end
)

addCommandHandler("addWindow",
function(root, windowTitle, x, y, w, h)
  windows[#windows+1] = windowTitle
  windowsX[#windowsX+1] = x
  windowsY[#windowsY+1] = y
  windowsW[#windowsW+1] = w
  windowsH[#windowsH+1] = h
end
)


bindKey("M", "down",
function()
  if isCursorShowing() then
    showCursor(false)
  else
    showCursor(true)
  end
end)

bindKey("mouse1", "both",
function()
  if isCursorShowing() then
  local mX, mY = getCursorPosition()
  local sx, sy = guiGetScreenSize()

  mX = sx*mX
  mY = sy*mY

  for i = 1, #windows do
    if mX > tonumber(windowsX[i]) + tonumber(windowsW[i]) - 15 and mX <  tonumber(windowsX[i]) + tonumber(windowsW[i]) and mY > tonumber(windowsY[i]) and mY < tonumber(windowsY[i]) + 20 then
      table.remove(windows, i)
      table.remove(windowsX, i)
      table.remove(windowsY, i)
      table.remove(windowsW, i)
      table.remove(windowsH, i)
    end
  end
end
end
)
