local composer = require( "composer" )
local fileHandler = require( "fileHandler" )

local scene = composer.newScene()



-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local creator = require("creator")

function getSceneGroup()
        return sceneGroup
end

local ar = {}
local maxRecords = {0,200,650,1025,1275,300,650,850,1500,2475}

local background

local function cleanMap()
        for i in ipairs(ar) do
                display.remove(ar[i])
        end
        ar = {}
end

function createMap( environment )
        cleanMap()
        local curLevel = fileHandler.getCurrentLevel()

        local arrow
        local j

        local planet = display.newEmbossedText(sceneGroup,"",display.screenOriginX + display.actualContentWidth*0.5,50,"PermanentMarker-Regular.ttf",50)
        local color = 
        {
                highlight = { r=0, g=0, b=0 },
                shadow = { r=0, g=0, b=0 }
        }
        planet:setFillColor(0.2,0.8,0.2)
        planet:setEmbossColor( color )
        planet.anchorX = 0.5

        local numberOfElements

        if (environment == 0) then
                planet.text = "Miscellaneous"
                planet:setFillColor(0,0,0.8)
                planet:setEmbossColor( color )

                arrow = creator.createArrowRight(display.screenOriginX + display.actualContentWidth*0.84,display.actualContentHeight*0.1+5) 
                background.fill.effect = "generator.radialGradient"
 
                background.fill.effect.color1 = { 1, 0.5, 1, 1 }
                background.fill.effect.color2 = { 0.5, 0, 0.5, 1 }
                background.fill.effect.center_and_radiuses  =  { 0.5, 0.5, 0.25, 0.75 }
                background.fill.effect.aspectRatio  = 1
                j = 1

                numberOfElements = 2
        elseif (environment == 1) then
                planet.text = "Grass Planet"
                arrow = creator.createArrowRight(display.screenOriginX + display.actualContentWidth*0.84,display.actualContentHeight*0.1+5) 
                arrow2 = creator.createArrowLeft(display.screenOriginX + display.actualContentWidth*0.14,display.actualContentHeight*0.1+5) 
                background.fill.effect = "generator.radialGradient"
 
                background.fill.effect.color1 = { 0.5, 0.5, 1, 1 }
                background.fill.effect.color2 = { 0.2, 0.2, 0.8, 1 }
                background.fill.effect.center_and_radiuses  =  { 0.5, 0.5, 0.25, 0.75 }
                background.fill.effect.aspectRatio  = 1
                j = 1

                table.insert(ar,arrow2)

                numberOfElements = 5
        else 
                planet.text = "Desert Planet"
                planet:setFillColor(1,1,0.4)
                planet:setEmbossColor( color )

                arrow = creator.createArrowLeft(display.screenOriginX + display.actualContentWidth*0.14,display.actualContentHeight*0.1+5) 
                background.fill.effect = "generator.radialGradient"
 
                background.fill.effect.color1 = { 1, 0.5, 0, 1 }
                background.fill.effect.color2 = { 0.6, 0.2, 0, 1 }
                background.fill.effect.center_and_radiuses  =  { 0.5, 0.5, 0.25, 0.75 }
                background.fill.effect.aspectRatio  = 1
                j = 6

                numberOfElements = 5
        end
        table.insert(ar,arrow)

        for i=0,numberOfElements-1 do
                local elementX = display.screenOriginX + display.actualContentWidth/8.67 + i * display.actualContentWidth/5.45
                local recordX = elementX+5
                local levelName
                if (environment == 0) then
                        if (i == 0) then
                                levelName = "Tutorial"
                        else 
                                levelName = "Credits"
                        end
                else
                        levelName = "Level "..i+j
                end
                local levelTitle = display.newText(sceneGroup, levelName, elementX, display.actualContentHeight*0.5-100, "ethnocentric rg.ttf", 20)
                local recordInPercentage 
                local percentage 
                local recordY = display.actualContentHeight*0.5+100
                local tree
                local treeY = display.actualContentHeight*0.5
                local playedColor = environment == 1 and { 0.1,1,0.1 } or { 1,1,0 }
                local availableColor = environment == 1 and { 0.6, 1, 0.6 } or { 1,1,0.6 }
                local state

                if (curLevel > j+i) then
                        if (maxRecords[i+j] == 0) then percentage = 100 else
                                percentage = (fileHandler.getRecord(i+j)/maxRecords[i+j])*100
                        end
                        recordInPercentage = display.newText(sceneGroup, math.round(percentage).." %", recordX, recordY, native.systemFontBold, 20, "right")
                        levelTitle:setTextColor( unpack(playedColor) )
                        state = "played"
                elseif (curLevel == j+i) then

                        if (fileHandler.getRecord(curLevel)==nil) then
                                recordInPercentage = display.newText(sceneGroup, "0 %", recordX, recordY, native.systemFontBold, 20)
                                levelTitle:setTextColor( unpack(availableColor))
                                state = "current"
                        else 
                                if (maxRecords[i+j] == 0) then percentage = 0 else percentage = (fileHandler.getRecord(i+j)/maxRecords[i+j])*100 end
                                recordInPercentage = display.newText(sceneGroup, math.round(percentage).." %", recordX, recordY, native.systemFontBold, 20)
                                levelTitle:setTextColor( unpack(playedColor) )
                                state = "played"
                        end
                else
                        recordInPercentage = display.newText(sceneGroup, "0 %", recordX, recordY, native.systemFontBold, 20)
                        levelTitle:setTextColor( 0.9, 0.9, 0.9 )
                        state = "closed"
                end

                if (environment == 0) then
                        recordInPercentage.text = ""
                        levelTitle:setTextColor( 0,0,1 )
                        elementX = display.screenOriginX + display.actualContentWidth*0.38 + i * display.actualContentWidth/3.8
                        levelTitle.x = elementX
                        if (i == 0) then
                                state = "tutorial"
                        end
                end

                tree = creator.createMapElement(elementX, treeY, state)
                table.insert(tree,i+j)

                table.insert(ar,tree)
                table.insert(ar,recordInPercentage)
                table.insert(ar,levelTitle)

                if display.screenOriginX + display.actualContentWidth/8.67 > 420 then
                        tree:scale(0.8,0.8)
                        levelTitle:scale(0.8,0.8)
                        recordInPercentage:scale(0.8,0.8)
                end
        end
        table.insert(ar,planet)
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    
    -- Code here runs when the scene is first created but has not yet appeared on screen
    sceneGroup = self.view

    background = display.newRect(sceneGroup,display.contentCenterX, display.contentCenterY, 1500,500)

    background.fill.effect = "generator.radialGradient"
 
    background.fill.effect.color1 = { 0.5, 0.5, 1, 1 }
    background.fill.effect.color2 = { 0.2, 0.2, 0.8, 1 }
    background.fill.effect.center_and_radiuses  =  { 0.5, 0.5, 0.25, 0.75 }
    background.fill.effect.aspectRatio  = 1
end


-- show()
function scene:show( event )
    

	local phase = event.phase

        if ( phase == "will" ) then
                composer.setVariable("env",1)
                createMap(1)

        elseif ( phase == "did" ) then
        end
end


-- hide()
function scene:hide( event )
	local phase = event.phase

	if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
                cleanMap()

        elseif ( phase == "did" ) then

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
        package.loaded["creator"] = nil

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
