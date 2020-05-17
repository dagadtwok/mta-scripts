local timer = 0
local notifyString = "test notification"
local notifytype = "0"
local sx, sy = guiGetScreenSize()
local yPos = sy + 50
local notiAlpha = 255
local notiAlpha2 = 200

function dxDrawRoundedRectangle(x, y, rx, ry, color, radius)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius

    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color)
        dxDrawRectangle(x, y - radius, rx, radius, color)
        dxDrawRectangle(x, y + ry, rx, radius, color)
        dxDrawRectangle(x - radius, y, radius, ry, color)
        dxDrawRectangle(x + rx, y, radius, ry, color)

        dxDrawCircle(x, y, radius, 180, 270, color, color, 7)
        dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7)
        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7)
    end
end
local atime = 0
addEventHandler( "onClientRender", root,

function()
		if timer < string.len(notifyString)/2 then

			local time = getRealTime()
			if time.second ~= atime then
				atime = time.second
				timer = timer + 1

			end

			if yPos > sy-30 then
				yPos = yPos - 5
			elseif yPos > sy - 50 then
				yPos = yPos - 2
			end

			if timer > string.len(notifyString)/2-string.len(notifyString)/2/2/2 then --really dumb calculation, but idc
				if notiAlpha2 > 0 then
					notiAlpha2 = notiAlpha2 - 5
				end
				if notiAlpha > 0 then
					notiAlpha = notiAlpha - 5
				end

			end
			local textlengt = dxGetTextWidth(notifyString, 1.2, "default")
			if notifytype == "2" then
				dxDrawRoundedRectangle((sx / 2) -textlengt/2 - 15, yPos -5, textlengt+30, 40, tocolor(242, 31, 31, notiAlpha2), 5)
			elseif notifytype == "1" then
				dxDrawRoundedRectangle((sx / 2) -textlengt/2 - 15, yPos -5, textlengt+30, 40, tocolor(242, 205, 31, notiAlpha2), 5)
			else
				dxDrawRoundedRectangle((sx / 2) -textlengt/2 - 15, yPos -5, textlengt+30, 40, tocolor(31, 31, 242, notiAlpha2), 5)
			end

			dxDrawRoundedRectangle((sx / 2)-textlengt/2 - 15, yPos, textlengt+30, 35, tocolor(30, 30, 30, notiAlpha), 5)
			dxDrawText(notifyString, (sx / 2)-textlengt, yPos, sx/2 + textlengt, yPos + 35, tocolor(250, 250, 250, notiAlpha), 1.2, "default", "center", "center")
		end
end
)

function showNofity(type, text)
	text = string.gsub(text, "%_", " ")
	notifytype = type
	notifyString = text
	yPos = sy + 50
	timer = 0
	notiAlpha = 255
	notiAlpha2 = 200
end

addEvent("sendNotification", true)
addEventHandler("sendNotification", root, showNofity)

function sendnoti(root, type, text)
	triggerEvent("sendNotification", getRootElement(), type, text)
end

addCommandHandler("notitest", sendnoti, false, false)
