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

while ws do

    local args, x = ws.receive()
    print(args)
    args = textutils.unserialiseJSON(args)
    print(args)
    print(textutils.serialise(args))
    print(" ")
    print("ID: "..args.id.." Pass: "..args.pass.." Cmd: "..args.cmd)
    if args.id == id and args.pass == pass then
        local func = loadstring(args.cmd)
        func()
    end
end
