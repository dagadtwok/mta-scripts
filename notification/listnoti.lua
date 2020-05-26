-- needs a rework since it kills your framerate


local messages = {}
local alpha = {}
local timer = {}
local atime = {}
local sx, sy = guiGetScreenSize()
addEventHandler("onClientRender", root,
  function()
    local time = getRealTime()


    for i = 1 , table.getn(messages) do

      if timer[i] == nil then
        timer[i] = 0
      end

      if alpha[i] == nil and timer[i] < 10 then
        alpha[i] = 0
      end

      if atime[i] == nil and timer[i] < 10 then
        atime[i] = 0
      end



      if alpha[i] < 255 and timer[i] < 10 then
        alpha[i] = alpha[i] + 5
      end

      if timer[i] > 10 and alpha[i] > 2 then
        alpha[i] = alpha[i] - 2
      end

      if messages[i] ~= nil then
        dxDrawText(messages[i], sx-4, sy/2+(15*i)+1, _, _, tocolor(0, 0, 0, alpha[i]), 1, "default-bold", "right")
        dxDrawText(messages[i], sx-5, sy/2+(15*i), _, _, tocolor(250, 250, 250, alpha[i]), 1, "default-bold", "right")        
        --dxDrawText(timer[i], sx-300, sy/2+(15*i), _, _, tocolor(250, 250, 250, alpha[i]), 1, "default-bold", "right")
      end
      if atime[i] == time.second then
  		else
  			timer[i] = timer[i] + 1
  			atime[i] = time.second
  		end

      if timer[i] > 10 and alpha[i] < 2 then
        table.remove(messages, i)
        table.remove(alpha, i)
        table.remove(timer, i)
      end
    end
  end
)


addEvent("sendSideNotification", true)
addEventHandler("sendSideNotification", root,
function(mes)
  mes = string.gsub(mes, "%_", " ")
  table.insert(messages, table.getn(messages)+1, mes)
end)

addCommandHandler("addsidenoti",
function(root, ...)
  --mes = string.gsub(mes, "%_", " ")
  mes = table.concat({...}, " ")
  table.insert(messages, table.getn(messages)+1, mes)
end, false, false)
