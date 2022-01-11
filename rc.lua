local tARGs = {...}
local url = tARGs[1]
local pass = tARGs[2]
local ws,err = http.websocket(url)
local id = tostring(os.getComputerID())
local doingScan = false
local selCmds = {'turtle.forward()','turtle.back()','turtle.turnLeft()','turtle.turnRight()','turtle.up()','turtle.down()'}
local surBlocks = {}
if ws then
    print("Connected To: "..url)
    print(os.getComputerID())
    print(pass)
end


function Scan()
    doingScan = true
    if turtle.inspect() then
    w,s = turtle.inspect()
    surBlocks.front = s.name
    else
    surBlocks.front = 'minecraft:None'
    end
    if turtle.inspectUp() then
    w,s = turtle.inspectUp()
    surBlocks.up = s.name
    else
    surBlocks.up = 'minecraft:None'
    end
    if turtle.inspectDown() then
    w,s = turtle.inspectDown()
    surBlocks.down = s.name
    else
    surBlocks.down = 'minecraft:None'
    end
    turtle.turnLeft()
    if turtle.inspect() then
    w,s = turtle.inspect()
    surBlocks.left = s.name
    else
    surBlocks.left = 'minecraft:None'
    end
    turtle.turnRight()
    turtle.turnRight()
    if turtle.inspect() then
    w,s = turtle.inspect()
    surBlocks.right = s.name
    else
    surBlocks.right = 'minecraft:None'
    end
    turtle.turnLeft()
    doingScan = false
    --print(textutils.serialise(surBlocks))
end

function contains(table,element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end
function RecCMD()
    while ws do
    local args, x = ws.receive()
    if args ~= nil then
    args = textutils.unserialiseJSON(args)
    if args.id == id and args.pass == pass and args.fromTurt == false then
        print(textutils.serialise(args))
        print(" ")
        print("ID: "..args.id.." Pass: "..args.pass.." Cmd: "..args.cmd)    
        if (contains(selCmds, args.cmd) and (doingScan == true)) then
        else    
            local func = loadstring(args.cmd)
            func()
            if args.doScan == 'yes' then
                Scan()
            end
        end
    end
end
end
end
print(err)

function SendCMD()
    while ws do
        os.sleep(0.5)
        local SendToSocket = {}
        local inv = {}
        for i = 1, 16 do
            if turtle.getItemDetail(i) == nil then
                inv["slot" .. i] = {name = "minecraft:Blank", count = 0}
            else
                inv["slot" .. i] = turtle.getItemDetail(i)
            end
        end
        local gpsx, gpsy, gpsz = gps.locate()
        local gpss = {}
        if gpsx == nil then    
            gpss.x = "NM"
            gpss.y = "NM"
            gpss.z = "NM"
        else
            gpss.x = tostring(gpsx)
            gpss.y = tostring(gpsy)
            gpss.z = tostring(gpsz)
        end
        SendToSocket.gps = gpss
        SendToSocket.id = tostring(id)
        SendToSocket.pass = pass
        SendToSocket.fromWss = false
        SendToSocket.log = false
        SendToSocket.fromTurt = true
        SendToSocket.surBlocks = surBlocks
        SendToSocket["Inventory"] = inv
        SendToSocket = textutils.serialiseJSON(SendToSocket)
        ws.send(SendToSocket)
    end
end
Scan()
while ws do
    parallel.waitForAll(RecCMD,SendCMD)
end
