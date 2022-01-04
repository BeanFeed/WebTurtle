local tARGs = {...}
local url = tARGs[1]
local pass = tARGs[2]
local ws,err = http.websocket(url)
turtle.select(1)

if ws then
    print("Connected To: "..url)
    print(os.getComputerID())
    print(pass)
    json
end

while ws do

    local args, x = ws.receive()
    args = textutils.unserialise(args)
    print("ID: "..args[id].." Pass: "..args[pass])
    if args.id == os.getComputerID() and args.pass == pass then
        
        print(args[cmd])
        local cmd = loadstring(args.cmd)
        cmd()
    end
end
