local playerCount = 0
addEventHandler("onClientPlayerWasted", root,
      function()
        triggerEvent("hideHud", root)
        triggerEvent("sendNotification", root, "2", "‎‎‎‎‎Wasted‎‎‎‎‎")
        setTimer(respawnPlayer, 6000, 1, source)
      end
)

function respawnPlayer(player)
        triggerEvent("showHud", player)
end

addEventHandler("onClientRender", root,
      function()
        local players = playerCount
        local textLenght = dxGetTextWidth(players .. " players online", 1, "default")

        local height = 150
        local sx, sy = guiGetScreenSize()
        dxDrawRectangle(0, sy - height, sx, height, tocolor(0, 0, 0, 150))

        dxDrawText(players .. " players online", sx - textLenght - 5, sy - height, _, _, tocolor(250, 250, 250, 255), 1, "default")
      end
)


addEvent( "totalPlayer", true)
addEventHandler("totalPlayer", root,
  function(players)
    playerCount = players
  end
)
