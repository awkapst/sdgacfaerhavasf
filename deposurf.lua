function Send(player,jumlah)
    RequestINFO={}
    RequestINFO.url="http://".. serverIP .."/app?namaplayer=".. player:upper() .."&jumlah="..jumlah
    x = httpReq(RequestINFO)
    return (x.body or "NULL")
end

function log(text)
    local filewrite = io.open("Donation.txt", "a+")
    filewrite:write(text.."\n")
    filewrite:close()
end

function logHttp(text)
    local filewrite = io.open("http.txt", "a+")
    filewrite:write(text.."\n")
    filewrite:close()
end

function hook(varlist)
    if varlist[0] == "OnConsoleMessage" then
        if varlist[1]:find("into the Donation Box") then
            player = varlist[1]:match("%[+%p+w+%w+"):sub(6) --PLAYER DNT
            jumlah = varlist[1]:match("s+%s+%p+%d+"):sub(5) --JUMLAH DNT
            jenis = "World Lock"
            total = 0
            sleep(1000)
            if varlist[1]:find("<") then
                bot:say("fake")
                log("Fake Donation From : "..player)
            else
                if varlist[1]:find("World Lock") then
                    total = jumlah
                elseif varlist[1]:find("Diamond Lock") then
                    jenis = "Diamond Lock"
                    total = jumlah * 100
                elseif varlist[1]:find("Blue Gem Lock") then
                    jenis = "Blue Gem Lock"
                    total = jumlah * 10000
                end
                log(player.." places "..jumlah.." "..jenis.." into the Donation Box")
                logHttp('['.. total ..']'..Send(player, total))
            end
        end
    end
end

bot = getBot()
bot:addHook(hook,varlist)