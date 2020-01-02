-- 积分墙对接
-- xtjfq.lua  

-- Create By TouchSpriteStudio on 16:26:24   
-- Copyright © TouchSpriteStudio . All rights reserved.
	
	
	

	
	
	
	
-- 积分墙对接
-- xiaoq.lua  

-- Create By TouchSpriteStudio on 13:15:24   
-- Copyright © TouchSpriteStudio . All rights reserved.




package.loaded['AWZ'] = nil
require("TSLib")
require("AWZ")
require("tsp")

local var={}
local jfq={}


jfq.url = 'http://ad.masaike2018.com/ad/'
jfq.model = ''
jfq.adid = '1185'
jfq.appid = '1487600417'
jfq.keyword	= '花束'
jfq.idfa = ''
jfq.os_version = ''
jfq.device = 'iPhone10,3'
jfq.udid = ''
jfq.callback = true
jfq.name = '聊天话术神器'
jfq.source = 'hbmh'
jfq.channel = 'mz'
jfq.bid = 'com.mei.kingkong'


function start()
	local info = getOnlineName()
	jfq.idfa = strSplit(info[8],":")[2]
	jfq.os_version = strSplit(info[3],":")[2]
	jfq.device = strSplit(info[3],":")[2]
	jfq.udid = strSplit(info[4],":")[2]
end

function idfa_idfaPc()
	jfq.model = 'idfaRepeat'
	local service = jfq.url..jfq.model
	local postArr = {}
	postArr.appid = jfq.appid
	postArr.source = jfq.source
	postArr.idfa = jfq.idfa
--	log(postArr)
	local postdata = ''
	for k,v in pairs(postArr) do
		postdata = postdata .. '&'..k..'='..v
	end
	local service = service .."?"..postdata
	log(service);
	local res = get(service)
	if res and (res['status'] == 1) then
		log(res);
		jfq.token = res.token
		log("排重成功","all")
		return true
	end
end

function idfa_click()
	jfq.model = 'click'
	local service = jfq.url..jfq.model
	local postArr = {}
	postArr.appid = jfq.appid
	postArr.source = jfq.source
	postArr.device = jfq.device
	postArr.idfa = jfq.idfa
	postArr.os = jfq.os_version

	if jfq.callback then
		postArr.callback = urlEncoder("http://wenfree.cn/api/Public/idfa/?service=Idfa.Callback&idfa="..jfq.idfa.."&appid="..jfq.appid)
	end
	
	local postdata = ''
	for k,v in pairs(postArr) do
		postdata = postdata .. '&'..k..'='..v
	end
	local service = service .."?"..postdata
	log(service)
	local res = get(service)
	log(res)
	if res and (res['status']) == 1 then
		log("点击成功","all")
		return true
	end
end

function up(name,other)
	local url = 'http://wenfree.cn/api/Public/idfa/'
	local idfalist ={}
	idfalist.service = 'Idfa.Idfa'
	idfalist.phonename = getDeviceName()
--	idfalist.phoneimei = getIMEI()
	idfalist.phoneos = jfq.os_version
	idfalist.idfa = jfq.idfa
	idfalist.ip = ip()
	idfalist.account = jfq.keyword
	idfalist.password = var.password
	idfalist.phone = var.phone
	idfalist.appid = jfq.appid
	idfalist.name = name
	idfalist.other = other
	log( post(url,idfalist) )
end

t={}
local degree = 85
t['agree']={0xff5100,"-196|-35|0xff7f00,-507|24|0xf2f2f2",degree,48,1124,707,1274}
t['skip']={0xf2f2f2,"506|-8|0xff4800,-17|-45|0xf2f2f2",degree,43,1190,713,1319}

function app()
	local timeLine = os.time()
	while os.time() - timeLine < rd(20,30) do
		if active(jfq.bid,5)then
			if d("agree",true,2)then
			elseif d("skip",true,2)then
			end
		end
		delay(1)
	end
end

function all()

	vpn.off()
	if false or (vpn.on())then
		awzNew()
		start()
		if (idfa_idfaPc())then
			up(jfq.name,'排重成功')
			if(idfa_click())then
				up(jfq.name,'点击成功')
				app()
			end
		end
	end
end

while (true) do
	local ret,errMessage = pcall(all)
	if ret then
	else
		log(errMessage)
		dialog(errMessage, 10)
		mSleep(2000)
	end
end








	