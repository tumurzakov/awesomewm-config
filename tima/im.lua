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
local awful = require("awful")

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
    local slave_width = math.ceil(wa.width / 3)

    local cls = p.clients
    if #cls > 0 then

        for k, c in ipairs(cls) do
            local g = {}

            if awful.rules.match(c, {class = 'Pidgin', role = "buddy_list"}) then
                g.width = contact_width
                g.height = wa.height
                g.x = 0;
                g.y = top_offset;
            elseif awful.rules.match(c, {class = 'Pidgin', role = "conversation"}) then
                g.width = chat_width
                g.height = chat_height
                g.x = contact_width + buffer
                g.y = top_offset;
            elseif awful.rules.match(c, {class = 'Skype', role = "ConversationsWindow"}) then
                g.width = chat_width
                g.height = chat_height
                g.x = contact_width + buffer
                g.y = top_offset + chat_height + buffer
            elseif awful.rules.match(c, {class = 'Skype'}) then
                g.width = contact_width
                g.height = wa.height
                g.x = wa.width - contact_width
                g.y = top_offset
            else
                g.x = index * slave_width
                g.y = slave_offset
                g.width = slave_width
                g.height = 500

                index = index + 1
            end

            c:geometry(g)
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
