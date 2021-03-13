local f = require("rockerboo.functional")

describe("functional", function()
	it("map list", function()
		assert.is_equal(f.map({ 1, 2, 3 }, function(v)
			return v + 1
		end), { 2, 3, 4 })
	end)

	it("reduce list", function()
		assert.is_equal(f.reduce({ 1, 2, 3 }, function(acc, v)
			return acc + v
		end), 6)
	end)

	it("filter list", function()
		assert.is_equal(f.filter({ 1, 2, 3 }, function(v)
			return v < 2
		end), { 2, 3 })
	end)

	it("join list", function()
		assert.is_equal(f.join({ "a", "b", "c" }, ""), "abc")
	end)
end)
