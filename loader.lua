local RAP = "https://raw.githubusercontent.com/jr0nzz/zanjihub/refs/heads/main/rideapet"

local byGameId = {
    [10035204815] = RAP,
}

local byPlaceId = {
    [124216119978534] = RAP,
}

local gameId = game.GameId
while gameId == 0 and game.PlaceId == 0 do
    task.wait()
    gameId = game.GameId
end

local url = byGameId[gameId] or byPlaceId[game.PlaceId]
if not url then
    return
end

for _ = 1, 3 do
    local ok, source = pcall(game.HttpGet, game, url)
    if ok and type(source) == "string" and source ~= "" then
        local chunk = loadstring(source)
        if chunk then
            chunk()
        end
        return
    end
    task.wait(0.5)
end
