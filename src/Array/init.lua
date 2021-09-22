local _M = {
  _VERSION = 0.1
}

function _M.isArray(t)
  if type(t) ~= 'table' then return false end

  for k, _ in pairs(t) do
    -- if has NaN key or key > length, return false
    if type(k) ~= 'number' or k > #t then return false end
  end

  return true
end

-- Copy raw Content
function _M.copy(t)
  if not _M.isArray(t) or #t == 0 then return {} end

  local t_new = {}
  for i = 1, #t do
    t_new[i] = t[i]
  end

  return t_new
end

-- concat a and b, return a new table
function _M.concat(a, b)
  if #a == 0 and #b == 0 then return {} end
  if #a == 0 then return b end
  if #b == 0 then return a end

  local a_copy = _M.copy(a)

  for i = 1, #b do
    a_copy[#a + i] = b[i]
  end

  return a_copy
end

-- like Array.prototype.map
-- return new table with callback items
function _M.map(t, callback)
  local mapCache = {}

  for i = 1, #t do
    mapCache[i] = callback(t[i])
  end

  return mapCache
end

-- return every table items fit callback
function _M.every(t, callback)
  for i = 1, #t do
    if not callback(t[i]) then return false end
  end

  return true
end

function _M.some(t, callback)
  for i = 1, #t do
    if callback(t[i]) then return true end
  end

  return false  
end

function _M.flat(t)
  local flatted = not _M.some(t, function (s)
    return _M.isArray(s)
  end)
  if flatted then return t end

  local cache = {}

  for _, v in pairs(t) do
    if _M.isArray(v) then
      cache = _M.concat(cache, _M.flat(v))
    else
      cache[#cache + 1] = v
    end
  end

  return cache
end

function _M.include(t, element)
  return _M.some(t, function (s) return s == element end)
end

function _M.at(t, index)
  if index > #t or index < - #t or index == 0 then
    return nil
  end

  if index > 0 then
    return t[index]
  else
    return t[#t + 1 + index]
  end
end

-- remove duplicate element
function _M.unique(t)
  local cache = {}
  local set = {}
  for _, v in ipairs(t) do
    cache[v] = true
  end

  for k, _ in pairs(cache) do
    set[#set + 1] = k
  end

  return set
end

function _M.indexOf(t, element)
  for i = 1, #t do
    if t[i] == element or _M.equal(t[i], element) then
      return i
    end
  end
  return -1
end

function _M.lastIndexOf(t, element)
  for i = #t, 1, -1 do
    if t[i] == element or _M.equal(t[i], element) then
      return i
    end
  end
  return -1
end

-- array deep equal
function _M.equal(a, b)
  if type(a) ~= type(b) then return false end
  if type(a) ~= 'table' then return a == b end

  if #a ~= #b then return false end

  for k, v in pairs(a) do
    if not _M.equal(v, b[k]) then return false end
  end

  return true
end

return _M
