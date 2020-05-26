
addEventHandler("onPlayerWasted", root,
      function()
        fadeCamera(source, false, 2, 5, 5, 5)
        setTimer(respawnPlayer, 5000, 1, source)
        triggerClientEvent(source, "hideHud", source)
        triggerClientEvent(source, "sendNotification", source, "2", "‎‎‎‎‎Wasted‎‎‎‎‎")
        triggerClientEvent(root, "sendSideNotification", root, getPlayerName(source) .. " died")
      end
)

function respawnPlayer(player)
        spawnPlayer(player, -2166.34814, 833.44263, 88.76160)
        fadeCamera(player, true, 2)
end

-- testing

addEventHandler("onPlayerJoin", root,
      function()
        playerCount = getPlayerCount()
        spawnPlayer(source, -2403.00000, -598.00000, 134.64844)
        setElementPosition(source, -2403.00000, -598.00000, 134.64844)
        setCameraTarget(source)
        fadeCamera(root, true, 1)
        triggerClientEvent(root, "sendSideNotification", root, getPlayerName(source) .. " connected")
      end
)


addEventHandler("onPlayerSpawn", root,
      function()
        --triggerClientEvent(root, "sendSideNotification", root, getPlayerName(source) .. " spawned.")
        triggerClientEvent(source, "showHud", source)
      end
)
addEventHandler("onPlayerQuit", root,
      function()
        triggerClientEvent(root, "sendSideNotification", root, getPlayerName(source) .. " left the game")
      end
)


addCommandHandler("kms",
  function(source)
    setElementHealth(source, 0)
  end
)

addCommandHandler("getpos",
  function(source)
    local x, y, z = getElementPosition(source)
    outputChatBox(x .. " " .. y .. " " .. z)
  end
)
addCommandHandler("gotoshop",
  function(source)
    setElementPosition(source, -2193.5546875, 640.5888671875, 49.442939758301)
  end
)

addCommandHandler("joinemu",
  function(source)
      spawnPlayer(source, -2403.00000, -598.00000, 134.64844)
      setElementPosition(source, -2403.00000, -598.00000, 134.64844)
      setCameraTarget(source)
      fadeCamera(source, true, 1)
    end
)
