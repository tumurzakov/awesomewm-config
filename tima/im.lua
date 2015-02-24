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
module("tima.im")

local function fair(p, orientation)
    local wa = p.workarea

    local index = 0
    local buffer = 5
    local top_offset = 25

    local contact_width = 250
    local chat_width = wa.width - contact_width * 2 - buffer * 2
    local chat_height = math.ceil((wa.height - top_offset) / 2)

    local slave_offset = 20;
    local slave_width = math.ceil(wa.width / 4);

    local cls = p.clients
    if #cls > 0 then

        for k, c in ipairs(cls) do
            local g = {}

            if index == 0 then
                g.width = contact_width;
                g.height = wa.height
                g.x = 0;
                g.y = top_offset;
            elseif index == 1 then
                g.width = contact_width;
                g.height = wa.height
                g.x = wa.width - contact_width;
                g.y = top_offset;
            elseif index == 2 then
                g.width = chat_width
                g.height = chat_height
                g.x = contact_width + buffer
                g.y = top_offset;
            elseif index == 3 then
                g.width = chat_width
                g.height = chat_height
                g.x = contact_width + buffer
                g.y = top_offset + chat_height + buffer;
            else
                g.x = (index - 4) * slave_width
                g.y = slave_offset;
                g.width = slave_width;
                g.height = 300
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
