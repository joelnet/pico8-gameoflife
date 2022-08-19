logs = {
  path = '.log',
  print = function(text)
    printh(dates.isodatetime()..' '..text, logs.path)
  end,
}