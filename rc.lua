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
    local args, x = ws.receive()
    args = textutils.unserialiseJSON(args)
    if args.id == id and args.pass == pass then
        print(textutils.serialise(args))
        print(" ")
        print("ID: "..args.id.." Pass: "..args.pass.." Cmd: "..args.cmd)
        if args.extra ~= nil then
            
        end
        local func = loadstring(args.cmd)
        func()
    end
end
print(err)

function Inv()
    while ws do
    os.sleep(5)
    local inv = {}
    for i = 1, 16 do
        inv["slot" .. i] = turtle.getItemDetail(i)
    end
    inv.fromWss = false
    inv.log = false
    --print(textutils.serialise(inv))
    inv = textutils.serialiseJSON(inv)
    ws.send(inv)
    end
end

while ws do
    parallel.waitForAll(RecCMD,Inv)
end
