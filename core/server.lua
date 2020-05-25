
addEventHandler("onPlayerWasted", root,
      function()
        fadeCamera(root, false, 2, 255, 255, 255)
        setTimer(respawnPlayer, 5000, 1, source)
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
        triggerClientEvent(root, "totalPlayer", root, getPlayerCount())
        setPlayerNameTagShowing(root, false)
      end
)


addEventHandler("onPlayerSpawn", root,
      function()
        triggerClientEvent(root, "totalPlayer", root, getPlayerCount())
      end
)
addEventHandler("onPlayerQuit", root,
      function()
        triggerClientEvent(root, "totalPlayer", root, getPlayerCount())
      end
)


addCommandHandler("kms",
  function()
    setElementHealth(root, 0)
  end
)

addCommandHandler("getpos",
  function(source)
    local x, y, z = getElementPosition(source)
    outputChatBox(x .. " " .. y .. " " .. z)
  end
)

addCommandHandler("joinemu",
  function(source)
      spawnPlayer(source, -2403.00000, -598.00000, 134.64844)
      setElementPosition(source, -2403.00000, -598.00000, 134.64844)
      setCameraTarget(source)
      fadeCamera(root, true, 1)
      triggerClientEvent(root, "totalPlayer", root, getPlayerCount())
    end
)
