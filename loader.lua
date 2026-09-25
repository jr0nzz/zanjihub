local RAP =
    "https://raw.githubusercontent.com/jr0nzz/zanjihub/refs/heads/main/rideapet.lua"

local SAE =
    "https://raw.githubusercontent.com/jr0nzz/zanjihub/refs/heads/main/stealanegg.lua"

local byGameId = {
    [10035204815] = RAP,
    [10563114921] = SAE,
}

local byPlaceId = {
    [124216119978534] = RAP,
    [107778070777162] = SAE,
}

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local gameId =
    game.GameId

while gameId == 0
    and game.PlaceId == 0
do
    task.wait()
    gameId = game.GameId
end

local url =
    byGameId[gameId]
    or byPlaceId[game.PlaceId]

if not url then
    return
end

for attempt = 1, 3 do
    local ok, source =
        pcall(
            game.HttpGet,
            game,
            url,
            true
        )

    if ok
        and type(source) == "string"
        and #source > 100
    then
        local chunk, compileError =
            loadstring(source)

        if type(chunk) == "function" then
            chunk()
            return
        end

        warn(
            "[ZANJIHUB] Loader compile failed: "
                .. tostring(compileError)
        )
    end

    task.wait(0.5)
end
