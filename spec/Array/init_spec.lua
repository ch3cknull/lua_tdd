require 'busted.runner'()

local Array = require('Array')

describe("Array.isArray", function()
  local fn = Array.isArray

  it("test should be false", function ()
    assert.is_true(fn({}))
    assert.is_true(fn({1,2,3}))
    assert.is_true(fn({1,2,3,{}}))
  end)
  it("test should be true", function ()
    assert.is_false(fn({1,2,3,a=1}))
  end)
end)


describe("Array.concat", function() 
  local fn = Array.concat
  it("Array.concat", function ()
    local a = {1,2,3}
    local b = {1,3}
    local c = {1,2,3,1,3}
    assert.are.same(fn(a, b), c)
  end)
end)

describe("Array.map", function() 
  local fn = Array.map

  it("Array.map", function ()
    local arr = {1,2,3}
    local res = {2,4,6}
    local mapped = fn(arr, function (s)
      return s * 2
    end)

    assert.are.same(mapped, res)
  end)
end)

describe("Array.every", function() 
  local fn = Array.every
  it("Array.every should true", function ()
    local res = fn({1,1,1}, function (s)
      return s == 1
    end)
    assert.is_true(res)
  end)
  it("Array.every should false", function ()
    local res = fn({1,1,2}, function (s)
      return s == 1
    end)
    assert.is_false(res)
  end)
end)

describe("Array.some", function() 
  local fn = Array.some
  it("Array.some should true", function ()
    local res = fn({1,1,2}, function (s)
      return s == 1
    end)
    assert.is_true(res)
  end)
  it("Array.some should false", function ()
    local res = fn({1,1,2}, function (s)
      return s == 1
    end)
    assert.is_true(res)
  end)
end)
