-- BAI_BankAccountInterest
-- Main driver class for BAI
--

BAI_BankAccountInterest = {}
BAI_BankAccountInterest.rate = 0.01
BAI_BankAccountInterest.commands = {
    --- call name, description, function
    { 'biSetInterestRate', 'sets annual bank account interest rate', 'setInterestRate' },
    { 'biGetInterestRate', 'gets annual bank account interest rate', 'getInterestRate' },
}

function BAI_BankAccountInterest:loadMap()
    g_messageCenter:subscribe(MessageType.PERIOD_CHANGED, self.onPeriodChanged, self)
end

function BAI_BankAccountInterest:onPeriodChanged()
    if g_currentMission:getIsServer() then
        local farms = g_farmManager.farmIdToFarm
        for _, farm in pairs(farms) do
            if farm.money ~= nil and farm.money > 0 then
                local interestAmount = farm.money * (BAI_BankAccountInterest.rate / 12)
                g_currentMission:addMoney(interestAmount, farm.farmId, MoneyType.INTEREST_PAID, true, true)
            end
        end
    end
end

-- Borrowed from Courseplay
function BAI_BankAccountInterest:init()
    self:registerConsoleCommands()
end

-- Borrowed from Courseplay
function BAI_BankAccountInterest:registerConsoleCommands()
    for _, commandData in ipairs(self.commands) do
        local name, desc, funcName = unpack(commandData)
        addConsoleCommand(name, desc, funcName, self)
    end
end

-- @param myRate rate to be set, expressed as float
function BAI_BankAccountInterest:setInterestRate(myRate)
    BAI_BankAccountInterest.rate = myRate
    print("BAI_bankAccountInterest.rate=" .. tostring(BAI_BankAccountInterest.rate))
    return BAI_BankAccountInterest.rate
end

function BAI_BankAccountInterest:getInterestRate()
    print("BAI_bankAccountInterest.rate=" .. tostring(BAI_BankAccountInterest.rate))
    return BAI_BankAccountInterest.rate
end

BAI_BankAccountInterest:init()
addModEventListener(BAI_BankAccountInterest)
