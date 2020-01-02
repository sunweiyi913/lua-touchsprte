-- 积分墙对接
-- main.lua  

-- Create By TouchSpriteStudio on 12:56:04   
-- Copyright © TouchSpriteStudio . All rights reserved.
	
	
	

	
--unlockDevice()
require("TSLib")
--require("tsp")

--res, code = http.request("http://ip.chinaz.com/getip.aspx");
--用http.get实现下载文件功能
function downFile(url, path)
	local sz = require("sz")
	local http = require("szocket.http")
--	local url = "http://wenfree.cn/api/Public/idfa/?service=Git.Get&url="..url
	local res, code = http.request(url);
	nLog(res)
	if code == 200 then
		local json = sz.json
		local data = json.decode(res)
		local body = data.data
		local file = io.open(path, "wb")
		if file then
			file:write(body)
			file:close()
			return status;
		else
			return -1;
		end
	else
		return status;
	end
end
--downFile("http://mu1234.applinzi.com/reply.txt",
--"/User/Media/TouchSprite/lua/reply.txt")

--检测指定文件是否存在
function file_exists(file_name)
    local f = io.open(file_name, "r")
    return f ~= nil and f:close()
end

game_lua = {
	{"UI",'https://img.wenfree.cn/nike-wenfree/UI.lua'},
	{"tsp",'https://img.wenfree.cn/nike-wenfree/tsp.lua'},
	{"nameStr",'https://img.wenfree.cn/nike-wenfree/nameStr.lua'},
	{"alz",'https://img.wenfree.cn/nike-wenfree/alz.lua'},
	{"AWZ",'https://img.wenfree.cn/nike-wenfree/AWZ.lua'},
	{"nike",'https://img.wenfree.cn/nike-wenfree/nike.lua'},
	{"main",'https://img.wenfree.cn/nike-wenfree/main.lua'},
}


local ver_ =  1
local name_ = "jfq_cd"
local v_url = 'http://wenfree.cn/api/Public/idfa/?service=Git.Update&name='..name_..'&v='..ver_

function get_(url)
	local sz = require("sz")
	local http = require("szocket.http")
	local res, code = http.request(url);
--	nLog(res);
	if code == 200 then
		local json = sz.json
		if res ~= nil then
			return json.decode(res)
		end
	end
end

local version = get_(v_url);
if version then
	if version.data then
		t1=os.time();
		nLog(t1)
		for i,v in ipairs(game_lua)do
			nLog(v[1])
			nLog(v[2])
			downFile(v[2],"/User/Media/TouchSprite/lua/"..v[1]..".lua")
			mSleep(30)
			toast(v[1],1)
		end
		nLog('end->'..os.time()-t1)
	else
		nLog('无需更新');
		for i,v in ipairs(game_lua)do
			if not(file_exists("/User/Media/TouchSprite/lua/"..v[1]..".lua"))then
				nLog('文件不存，下载一个->'..v[1])
				downFile(v[2],"/User/Media/TouchSprite/lua/"..v[1]..".lua")
				if v[1] == 'main' then
					downFile(v[2],"/User/Media/TouchSprite/"..v[1]..".lua")
				end
			end
		end
	end
end
require("jfq")




	