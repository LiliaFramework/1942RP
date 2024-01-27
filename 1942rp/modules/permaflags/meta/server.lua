local playerMeta = FindMetaTable("Player")
function playerMeta:notifyP(tx) -- helper func
	self:notify(tx)
	self:ChatPrint(tx)
end

function playerMeta:getPermFlags()
	return self:getLiliaData("permflags", "")
end

function playerMeta:setPermFlags(val)
	self:setLiliaData("permflags", val or "")
	self:saveLiliaData()
end

function playerMeta:givePermFlags(flags)
	local curFlags = self:getPermFlags()
	for i = 1, #flags do
		local flag = flags[i]
		if not self:hasPermFlag(flag) and not self:hasFlagBlacklist(flag) then curFlags = curFlags .. flag end
	end

	self:setPermFlags(curFlags)
	if self.liaCharList then
		for k, v in pairs(self.liaCharList) do
			local char = lia.char.loaded[v]
			if char then char:giveFlags(flags) end
		end
	end
end

function playerMeta:takePermFlags(flags)
	local curFlags = self:getPermFlags()
	for i = 1, #flags do
		curFlags = curFlags:gsub(flags[i], "")
	end

	self:setPermFlags(curFlags)
	if self.liaCharList then
		for k, v in pairs(self.liaCharList) do
			local char = lia.char.loaded[v]
			if char then char:takeFlags(flags) end
		end
	end
end

function playerMeta:hasPermFlag(flag)
	if not flag or #flag ~= 1 then return end
	local curFlags = self:getPermFlags()
	for i = 1, #curFlags do
		if curFlags[i] == flag then return true end
	end
	return false
end

function playerMeta:getFlagBlacklist()
	return self:getLiliaData("flagblacklist", "")
end

function playerMeta:setFlagBlacklist(flags)
	self:setLiliaData("flagblacklist", flags)
	self:saveLiliaData()
end

function playerMeta:addFlagBlacklist(flags, blacklistInfo)
	local curBlack = self:getFlagBlacklist()
	for i = 1, #flags do
		local curFlag = flags[i]
		if not self:hasFlagBlacklist(curFlag) then curBlack = curBlack .. flags[i] end
	end

	self:setFlagBlacklist(curBlack)
	self:takePermFlags(flags)
	if blacklistInfo then
		local blacklistLog = self:getLiliaData("flagblacklistlog", {})
		blacklistInfo.starttime = os.time()
		blacklistInfo.time = blacklistInfo.time or 0
		blacklistInfo.endtime = blacklistInfo.time <= 0 and 0 or (os.time() + blacklistInfo.time)
		blacklistInfo.admin = blacklistInfo.admin or "N/A"
		blacklistInfo.adminsteam = blacklistInfo.adminsteam or "N/A"
		blacklistInfo.active = true
		blacklistInfo.flags = blacklistInfo.flags or ""
		blacklistInfo.reason = blacklistInfo.reason or "N/A"
		table.insert(blacklistLog, blacklistInfo)
		self:setLiliaData("flagblacklistlog", blacklistLog)
		self:saveLiliaData()
	end
end

function playerMeta:removeFlagBlacklist(flags)
	local curBlack = self:getFlagBlacklist()
	for i = 1, #flags do
		local curFlag = flags[i]
		curBlack = curBlack:gsub(curFlag, "")
	end

	self:setFlagBlacklist(curBlack)
end

function playerMeta:hasFlagBlacklist(flag)
	local flags = self:getFlagBlacklist()
	for i = 1, #flags do
		if flags[i] == flag then return true end
	end
	return false
end

function playerMeta:hasAnyFlagBlacklist(flags)
	for i = 1, #flags do
		if self:hasFlagBlacklist(flags[i]) then return true end
	end
	return false
end