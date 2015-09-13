local tlz = {}

function tlz.clearTable(table)
	for key in pairs(table) do
		table[key] = nil
	end
end

function tlz.HSL2RGB(hue,sat,lum)
	local c = (1 - math.abs(2 * lum - 1)) * sat
	local h = hue/60
	local x = c * (1 - math.abs(h % 2 - 1))
	local m = lum - 0.5 * c
	
	c = c + m
	x = x + m
	
	c = c * 255
	x = x * 255
	m = m * 255
	
	h = math.floor(h + 1)
	
	local r = {c,x,m,m,x,c}
	local g = {x,c,c,x,m,m}
	local b = {m,m,x,c,c,x}

	return {r[h],g[h],b[h]}
end

function tlz.flipDir(dir,xf,yf)
	dir = math.rad(dir)
	dir = math.atan2(math.sin(dir) * yf,math.cos(dir) * xf)
	return math.deg(dir)
end

function tlz.c2c(x1,y1,r1,x2,y2,r2)
	local x = x2 - x1
	local y = y2 - y1
	local r = r1 + r2
	if(x*x + y*y < r^2)then
		return r - (x*x + y*y)^0.5, math.atan2(y,x)
	end
	
	return false,false
end

function tlz.l2c(x1,y1,dir,x2,y2,r2)
	local x = x2 - x1
	local y = y2 - y1
	
	local xr = x * math.cos(-dir) - y * math.sin(-dir)
	local yr = x * math.sin(-dir) + y * math.cos(-dir)
	
	if(math.abs(yr) < r2 and xr > r2)then
		return xr-r2,yr
	end
	
	return false,false
end

return tlz