local function Send(player,jumlah)
    local data = request("GET", "http://".. serverIP .."/app?namaplayer=".. player .."&jumlah="..jumlah)
    if data ~= "" and data ~= nil then
        logDB(data)
    end
end
 
function debug(text)
    local filewrite = io.open("debug.txt", "a+")
    filewrite:write(text.."\n")
    filewrite:close()
end

function log(text)
    local filewrite = io.open("info.txt", "a+")
    filewrite:write(text.."\n")
    filewrite:close()
end

function logDB(text)
    local filewrite = io.open("logDB.txt", "a+")
    filewrite:write(text.."\n")
    filewrite:close()
end

function hook(varlist)
    if varlist[0] == "OnConsoleMessage" then
        jumlah = 0
        local total = 0
        if varlist[1]:find("into the Donation Box") then
            debug(varlist[1])
            sleep(1000)
            if varlist[1]:find("<") then
                say("/ban "..(varlist[1]:gsub("`.",""):match("<(.+)>")))
            else
                if varlist[1]:find("World Lock") then
                    player = varlist[1]:match("%[+%p+w+%w+"):sub(6) --PLAYER DNT
                    jumlah = varlist[1]:match("s+%s+%p+%d+"):sub(5) --JUMLAH DNT
                    total = jumlah
                    Send(player:upper(),jumlah)
                    log("Real Donation Detected!\nPlayer Name : "..player.."\nAmount : "..total)
                elseif varlist[1]:find("Diamond Lock") then
                    player = varlist[1]:match("%[+%p+w+%w+"):sub(6) --PLAYER DNT
                    jumlah = varlist[1]:match("s+%s+%p+%d+"):sub(5) --JUMLAH DNT
                    total = jumlah * 100
                    Send(player:upper(),jumlah*100)
                    log("Real Donation Detected!\nPlayer Name : "..player.."\nAmount : "..total)
                elseif varlist[1]:find("Blue Gem Lock") then
                    player = varlist[1]:match("%[+%p+w+%w+"):sub(6) --PLAYER DNT
                    jumlah = varlist[1]:match("s+%s+%p+%d+"):sub(5) --JUMLAH DNT
                    total = jumlah * 10000
                    Send(player:upper(),jumlah*10000)
                    log("Real Donation Detected!\nPlayer Name : "..player.."\nAmount : "..total)
                end
            end
        end
    end
end

addHook("Donate", hook)

function sendDC()
    wh = {}
    wh.url = whRecon
    wh.username = "BOT CHECKER"
    wh.content = "<@515505041810128901> BOT Deposit "..getBot().status
    webhook(wh)
end

function sendHooks()
    if getBot().status == "online" then
        desc = getBot().status
    else
        desc = getBot().status
    end
    colors = math.random(1111111,9999999)
    os.time()
    time = os.date( "%A, %B %d %Y, %H:%M")

    wh = {}
    wh.url = whUpdate.."/messages/"..msgId.."?wait=true"
    wh.username = "BOT CHECKER"
    wh.embed = '{"description": "Last Updated : <t:'..os.time()..':R>", "author": {"name": "Status Bot Depo","icon_url": "https://i.imgur.com/NqepEJ8.png"}, "fields": [{"name": "Bot Name","value": "'.. getBot().name ..'","inline": "true"},{"name": "Status","value": "'.. desc ..'","inline": "true"}], "footer": {"text": "Last Update : '..time..'"}, "color": "'..colors..'"}'
    wh.edit = true
    webhook(wh)
end

while true do
    while getBot().captcha:find("Wrong") or getBot().captcha:find("Couldn't") do
        connect()
        sleep(30000)
    end
    if getBot().status ~= "online" then
        sendDC()
        sleep(1000)
        while getBot().status ~= "online" do
            sleep(10000)
        end
        sendDC()
        sleep(2000)
    end
    sendHooks()
    sleep(60000)
end
