-----------------------------------------------------------------------------------------
--
-- environment.lua
--
-----------------------------------------------------------------------------------------
local M = {}

local mainGroup = display.newGroup()
local playerGroup = display.newGroup()
local backGroup = display.newGroup()

local block, blockTop, blockEndTop, blockStartTop, blockStart, blockEnd, blockBottomEnd, blockBottomEndEdge, blockBottomStart, blockBottomStartEdge, movingBlock, 
    background, stone

M.setEnvironment = function( environment )
    local suffix = ".png"

    if (environment == 2) then
        suffix = "_desert.png"
    end
    
        background = "BG"..suffix
        block = "5"..suffix
        blockTop = "2"..suffix
        blockEndTop = "3"..suffix
        blockStartTop = "1"..suffix
        blockStart = "4"..suffix
        blockEnd = "6"..suffix
        blockBottomEnd = "7"..suffix
        blockBottomEndEdge = "8"..suffix
        blockBottomStart = "11"..suffix
        blockBottomStartEdge = "10"..suffix
        movingBlock = "19"..suffix
        stone = "Stone"..suffix
end

M.getStone = function()
    return stone
end

M.getBackground = function()
    return background
end

M.getBlock = function()
    return block
end

M.getBlockTop = function()
    return blockTop
end

M.getBlockEndTop = function()
    return blockEndTop
end

M.getBlockStartTop = function()
    return blockStartTop
end

M.getBlockStart = function()
    return blockStart
end

M.getBlockEnd = function()
    return blockEnd
end

M.getBlockBottomEnd = function()
    return blockBottomEnd
end

M.getBlockBottomEndEdge = function()
    return blockBottomEndEdge
end

M.getBlockBottomStart = function()
    return blockBottomStart
end

M.getBlockBottomStartEdge = function()
    return blockBottomStartEdge
end

M.getMovingBlock = function()
    return movingBlock
end


return M