---------------------------------------------------------------------------
-- @author Temir Umurzakov temir@umurzakov.com
-- @copyright 2008 Julien Danjou
-- @copyright 2010 Vain
-- @copyright 2013 Temir Umurzakov
-- @release v3.4.6
---------------------------------------------------------------------------

-- Grab environment we need
local ipairs = ipairs
local math = math
local beautiful = beautiful
local tonumber = tonumber
local awful = awful

-- Central working area that overlap others small.
-- Small windows could replace main window by moving it
-- with <META> + mouse left button key. 
-- Very comfortable for working with many terminals.
--

--- Fair layouts module for awful / vain
module("tima.butterfly")

local function fair(p, orientation)
    local wa = p.workarea

    local top_offset = 40;
    local slave_offset = 20;
    local win_width = math.ceil(wa.width / 2) - 5;
    local win_height = math.ceil(wa.height / 2) - 10;
    local main_x = math.ceil(win_width / 2);
    local main_y = math.ceil(win_height / 2);
    local slave_width = math.ceil(wa.width / 8);

    local main_width = math.ceil(wa.width * 0.8)
    local main_height = math.ceil(wa.height * 0.7)
    local main_wdiff = math.ceil(wa.width - main_width)
    local main_hdiff = math.ceil(wa.height - main_height)
    local main_x = math.ceil(main_wdiff / 2)
    local main_y = math.ceil(main_hdiff / 2)

    local index = 0;
    local first = true;

    local cls = p.clients
    if #cls > 0 then
        for k, c in ipairs(cls) do
            local g = {}

            g.width = win_width
            g.height = win_height

            if index == 0 then
                g.width = main_width
                g.height = main_height
                g.x = main_x
                g.y = main_y
                first = false
            else
                if index == 1 then
                    g.x = 0;
                    g.y = top_offset;
                elseif index == 2 then
                    g.x = win_width + 10;
                    g.y = top_offset;
                elseif index == 3 then
                    g.x = win_width + 10;
                    g.y = win_height + top_offset;
                elseif index == 4 then
                    g.x = 0;
                    g.y = win_height + top_offset;
                else
                    -- i don't know what to do with this windows
                    -- lets place them in the center
                    g.x = (index - 5) * slave_width
                    g.y = slave_offset;
                    g.width = slave_width;
                    g.height = 150 
                end
            end

            c:geometry(g)

            index = index + 1
        end
    end
end

--- Horizontal fair layout.
-- @param screen The screen to arrange.
horizontal = {}
horizontal.name = "fairh"
function horizontal.arrange(p)
    return fair(p, "east")
end

-- Vertical fair layout.
-- @param screen The screen to arrange.
name = "fairv"
function arrange(p)
    return fair(p, "south")
end
