local f = require("rockerboo.functional")

describe("functional", function()
	it("map list", function()
		assert.are.same(f.map(function(v)
			return v + 1
		end)({ 1, 2, 3 }), { 2, 3, 4 })
	end)

	it("reduce list", function()
		assert.are.same(f.reduce(function(acc, v)
			return acc + v
		end, 0)({ 1, 2, 3 }), 6)
	end)

	it("filter list", function()
		assert.are.same(f.filter(function(v)
			return v < 2
		end)({ 1, 2, 3 }), { 1 })
	end)

  it("contains in list", function()
    assert.is_true(f.contains(1)({1, 2, 3}))
  end)
  
	it("join list", function()
		assert.are.same(f.join("")({ "a", "b", "c" }), "abc")
	end)
end)
