local LibDraw = LibStub("LibDraw-1.0")
local DMW = DMW
local magicScale = 5/256

local function WorldToScreen(wX, wY, wZ)
	local ResolutionCoef = WorldFrame:GetWidth() / lb.GetWindowSize()
	local sX, sY = lb.WorldToScreen(wX, wY, wZ);
	if sX and sY then
		return sX * ResolutionCoef, -sY * ResolutionCoef;
	else
		return sX, sY;
	end
end

-- local function WorldToScreenRaw(wX, wY, wZ)
--     local sX, sY = _G.WorldToScreen(wX, wY, wZ)
--     if sX and sY then
--         return sX, -(WorldFrame:GetTop() - sY)
--     else
--         return sX, sY
--     end
-- end

function DMW.Helpers.DrawLine(sx, sy, sz, ex, ey, ez)
    if not DMW.Settings.profile.Helpers.DirectX then
        local startx, starty = WorldToScreen(sx, sy, sz)
        local endx, endy = WorldToScreen(ex, ey, ez)
        if (endx == nil or endy == nil) and (startx and starty) then
            local i = 1
            while (endx == nil or endy == nil) and i < 50 do
                endx, endy = WorldToScreen(GetPositionBetweenPositions(ex, ey, ez, sx, sy, sz, i))
                i = i + 1
            end
        elseif (startx == nil or starty == nil) and (endx and endy) then
            local i = 1
            while (startx == nil or starty == nil) and i < 50 do
                startx, starty = WorldToScreen(GetPositionBetweenPositions(sx, sy, sz, ex, ey, ez, i))
                i = i + 1
            end
	    end
		LibDraw.Draw2DLine(startx, starty, endx, endy)
    else
        local sWidth, sHeight = GetWoWWindow()
        local startx, starty, sFront = WorldToScreenRaw(sx, sy, sz)
        local endx, endy, eFront = WorldToScreenRaw(ex, ey, ez)
        if eFront and sFront then
            Draw2DLine(startx * sWidth, starty * sHeight, endx * sWidth, endy * sHeight, 4)
        end
	end
end

function DMW.Helpers.DrawText(text, font, x, y, z)
	if not DMW.Settings.profile.Helpers.DirectX then
		LibDraw.Text(text, font, x, y, z)
    else
        local sWidth, sHeight = GetWoWWindow()
        local o2dX, o2dY, oFront = WorldToScreenRaw(x, y, z)
        Draw2DText(o2dX * sWidth, o2dY * sHeight, text, 24)
	end
end

function DMW.Helpers.DrawColor(r,g,b,a)
    -- if a then a = a * 0.01 else a = 1 end
    if not a or a == 0 then a = 1 end
    if r > 1 or g > 1 or b > 1 then
        r = r / 255
        g = g / 255
        b = b / 255
    end
    if not DMW.Settings.profile.Helpers.DirectX then
		LibDraw.SetColorRaw(r,g,b,a)
    else
        SetDrawColor(r,g,b,a)
	end
end

local function convertToRaw(x,y)
    local sWidth, sHeight = GetWoWWindow()
end

function DMW.Helpers.DrawArc(x, y, z, size, arc, rotation)
    local lx, ly, nx, ny, fx, fy = false, false, false, false, false, false
    local half_arc = arc * 0.5
    local ss = (arc/half_arc)
    local as, ae = -half_arc, half_arc
    local px, py = WorldToScreen(x, y, z)
    for v = as, ae, ss do
        nx, ny = WorldToScreen( (x+cos(rotation+rad(v))*size), (y+sin(rotation+rad(v))*size), z )
        if (nx == nil or ny == nil) and (px and py) then
            local i = 1
            while (nx == nil or ny == nil) and i < 50 do
                nx, ny = WorldToScreen(GetPositionBetweenPositions((x+cos(rotation+rad(v))*size), (y+sin(rotation+rad(v))*size), z, x, y, z, i))
                i = i + 1
            end
        end
        if lx and ly then
            LibDraw.Draw2DLine(lx, ly, nx, ny)
        else
            fx, fy = nx, ny
        end
        lx, ly = nx, ny
    end
    LibDraw.Draw2DLine(px, py, lx, ly)
    LibDraw.Draw2DLine(px, py, fx, fy)
end
