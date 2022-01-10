local tARGs = {...}
local url = tARGs[1]
local pass = tARGs[2]
local ws,err = http.websocket(url)
turtle.select(1)
local id = tostring(os.getComputerID())
if ws then
    print("Connected To: "..url)
    print(os.getComputerID())
    print(pass)
end



function RecCMD()
    while ws do
    local args, x = ws.receive()
    if args ~= nil then
    args = textutils.unserialiseJSON(args)
    if args.id == id and args.pass == pass then
        print(textutils.serialise(args))
        print(" ")
        print("ID: "..args.id.." Pass: "..args.pass.." Cmd: "..args.cmd)    
        local func = loadstring(args.cmd)
        func()
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
        SendToSocket.fromWss = false
        SendToSocket.log = false
        SendToSocket["Inventory"] = inv
        SendToSocket = textutils.serialiseJSON(SendToSocket)
        ws.send(SendToSocket)
    end
end

while ws do
    parallel.waitForAll(RecCMD,SendCMD)
end
