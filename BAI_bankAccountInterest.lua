-- BAI_bankAccountInterest
-- Main driver class for BAI
--

BAI_bankAccountInterest = {}
BAI_bankAccountInterest.rate = 0.01
BAI_bankAccountInterest.commands = {
    --- call name, description, function
    { 'biSetInterestRate', 'sets annual bank account interest rate', 'setInterestRate' },
    { 'biGetInterestRate', 'gets annual bank account interest rate', 'getInterestRate' },
}

function BAI_bankAccountInterest:loadMap()
    g_messageCenter:subscribe(MessageType.PERIOD_CHANGED, self.onPeriodChanged, self)
end

function BAI_bankAccountInterest:onPeriodChanged()
    if g_currentMission:getIsServer() then
        local farms = g_farmManager.farmIdToFarm
        for _, farm in pairs(farms) do
            if farm.money ~= nil and farm.money > 0 then
                local interestAmount = farm.money * (BAI_bankAccountInterest.rate / 12)
                g_currentMission:addMoney(interestAmount, farm.farmId, MoneyType.INTEREST_PAID, true, true)
            end
        end
    end
end

-- Borrowed from Courseplay
function BAI_bankAccountInterest:init()
    self:registerConsoleCommands()
end

-- Borrowed from Courseplay
function BAI_bankAccountInterest:registerConsoleCommands()
    for _, commandData in ipairs(self.commands) do
        local name, desc, funcName = unpack(commandData)
        addConsoleCommand(name, desc, funcName, self)
    end
end

-- @param myRate rate to be set, expressed as float
function BAI_bankAccountInterest:setInterestRate(myRate)
    BAI_bankAccountInterest.rate = myRate
    print("BAI_bankAccountInterest.rate=" .. tostring(BAI_bankAccountInterest.rate))
    return BAI_bankAccountInterest.rate
end

function BAI_bankAccountInterest:getInterestRate()
    print("BAI_bankAccountInterest.rate=" .. tostring(BAI_bankAccountInterest.rate))
    return BAI_bankAccountInterest.rate
end

BAI_bankAccountInterest:init()
addModEventListener(BAI_bankAccountInterest)

-- Add Money Type and entries needed to display on finance screen

table.insert(FinanceStats.statNames, "interestPaid")
FinanceStats.statNameToIndex["interestPaid"] = #FinanceStats.statNames

FinanceStats.new = Utils.overwrittenFunction(FinanceStats.new, function(customMt, superFunc)
    local self = superFunc(customMt)
    FinanceStats.statNamesI18n["interestPaid"] = g_i18n:getText("bai_finance_interestPaid", g_currentModName)
    return self
end)

MoneyType.INTEREST_PAID = MoneyType.register("interestPaid", "bai_finance_interestPaid", g_currentModName)
