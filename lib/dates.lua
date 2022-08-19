dates = {
  isodate = function()
    local year = stat(80)
    local month = stat(81) >= 10 and stat(81) or '0'..stat(81)
    local day = stat(82) >= 10 and stat(82) or '0'..stat(82)
    return year..'-'..month..'-'..day
  end,
  isodatetime = function()
    local hours = stat(83) >= 10 and stat(83) or '0'..stat(83)
    local minutes = stat(84) >= 10 and stat(84) or '0'..stat(84)
    local seconds = stat(85) >= 10 and stat(85) or '0'..stat(85)
    return dates.isodate()..'T'..hours..':'..minutes..':'..seconds..'Z'
  end,
}