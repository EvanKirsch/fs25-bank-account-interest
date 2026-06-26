-- BAI_FinanceStatsExt
-- Add Money Type and entries needed to display on finance screen
--

table.insert(FinanceStats.statNames, "interestPaid")
FinanceStats.statNameToIndex["interestPaid"] = #FinanceStats.statNames

FinanceStats.new = Utils.overwrittenFunction(FinanceStats.new, function(customMt, superFunc)
    local self = superFunc(customMt)
    FinanceStats.statNamesI18n["interestPaid"] = g_i18n:getText("bai_finance_interestPaid", g_currentModName)
    return self
end)

MoneyType.INTEREST_PAID = MoneyType.register("interestPaid", "bai_finance_interestPaid", g_currentModName)
