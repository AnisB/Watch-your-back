-- Extend tostring to work better on tables
-- make it output in {a,b,c...;x1=y1,x2=y2...} format; use nexti
-- only output the LH part if there is a table.n and members 1..n
--   x: object to convert to string
-- returns
--   s: string representation
function tostring(x)
  local s
  if type(x) == "table" then
    s = "{"
    local i, v = next(x)
    while i do
      s = s .. tostring(i) .. "=" .. tostring(v)
      i, v = next(x, i)
      if i then s = s .. "," end
    end
    return s .. "}"
  else return %tostring(x)
  end
end

-- Extend print to work better on tables
--   arg: objects to print
function print(...)
  for i = 1, getn(arg) do arg[i] = tostring(arg[i]) end
  call(%print, arg)
end