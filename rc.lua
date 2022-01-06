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
    args = textutils.unserialiseJSON(args)
    if args.id == id and args.pass == pass then
        print(textutils.serialise(args))
        print(" ")
        print("ID: "..args.id.." Pass: "..args.pass.." Cmd: "..args.cmd)
        local func = loadstring(args.cmd)
        func()
    end
end
