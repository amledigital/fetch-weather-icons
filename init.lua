-- http://lua-users.org/wiki/FileInputOutput

-- see if the file exists
function file_exists(file)
	local f = io.open(file, "rb")
	if f then
		f:close()
	end
	return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function lines_from(file)
	if not file_exists(file) then
		return {}
	end
	local lines = {}
	for line in io.lines(file) do
		lines[#lines + 1] = line
	end
	return lines
end

-- tests the functions above
local file = "../../arc_mirror/components/util/weatherFunctions.js"
local lines = lines_from(file)

local icons = {}

-- print all line numbers and their contents
for k, v in pairs(lines) do
	for w in v:gmatch("%S+") do
		if string.match(w, "^fa") then
			local icon = w

			icon = icon:gsub(";", "")
			icon = icon:gsub("[()]", "")
			icon = icon:gsub(",", "")

			if icons[icon] == nil then
				icons[icon] = true
				table.insert(icons, icon)
			end
		end
	end
end

Out = io.open("./910-weather-icons.txt", "w")
Out:write(table.concat(icons, ", \n"))
Out:close()

print(table.concat(icons, ", "))
