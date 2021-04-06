--
-- Functional functions for lists which are tables
--
local F = {}

-- @param array = table -- { "value", "x" }
-- @param fn = function -- function(currentValue, index, array)
F.map = function(fn)
	return function(array)
		local result = {}

		for i, v in pairs(array) do
			table.insert(result, fn(v, i, array))
		end

		print(vim.inspect(result))

		return result
	end
end

-- @param array = table -- { "value", "x" }
-- @param fn = function -- function(accumulator, currentValue, index, array)
F.reduce = function(fn, initial)
	return function(array)
		local result = initial
		for i, v in ipairs(array) do
			result = fn(result, v, i, array)
		end

		return result
	end
end

-- @param array = table -- { "value", "x" }
-- @param fn = function -- function(currentValue, index, array)
F.filter = function(fn)
	return function(array)
		local result = {}

		for i, v in ipairs(array) do
			if fn(v, i, array) then
				table.insert(result, v)
			end
		end

		return result
	end
end

F.any = function(fn)
	return function(array)
		for _, v in ipairs(array) do
			if fn(v) then
				return true
			end
		end

		return false
	end
end

F.find = function(fn)
	return function(array)
		for _, v in ipairs(array) do
			if fn(v) then
				return v
			end
		end
	end
end

F.flatten = function(array)
	return F.reduce(function(acc, value)
		if type(value) == "table" then
			for _, v in ipairs(value) do
				table.insert(acc, v)
			end
		else
			table.insert(acc, value)
		end

		return acc
	end, {})(array)
end

-- @param array = table -- { "a", "b" }
-- @param value = string | number -- "a"
-- @return boolean
F.contains = function(value)
	return function(array)
		for _, v in ipairs(array) do
			if v == value then
				return true
			end
		end

		return false
	end
end

-- @param array = table -- { "value", "x" }
-- @param sep = string -- ", "
-- @return string -- "value, x"
F.join = function(sep)
	return function(array)
		local i = 1
		local result = ""

		while i < #array + 1 do
			if i == 1 then
				result = array[i]
			elseif array[i] ~= nil then
				result = result .. sep .. array[i]
			end
			i = i + 1
		end

		return result
	end
end

return F
