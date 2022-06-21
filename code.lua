function changePairColor(entityPair,colorPair)
    originalColorData={}
    originalColorData[1]=sim.changeEntityColor(entityPair[1],colorPair[1])
    originalColorData[2]=sim.changeEntityColor(entityPair[2],colorPair[2])
end

function restorePairColor()
    if originalColorData then
        sim.restoreEntityColor(originalColorData[1])
        sim.restoreEntityColor(originalColorData[2])
        originalColorData=nil
    end
end

function sysCall_init()
    local robotBase=sim.getObjectHandle('irb360')
    robotCollection=sim.createCollection(0)
    sim.addItemToCollection(robotCollection,sim.handle_tree,robotBase,0)
    collisionColors={{1,0,0},{1,0,1}} -- collider and collidee
end

function sysCall_sensing()
    local result,pairHandles=sim.checkCollision(robotCollection,sim.handle_all)
    restorePairColor()
    if result>0 then
        -- Change color of the collection and the collidee:
        changePairColor({robotCollection,pairHandles[2]},collisionColors)
        -- Change color of the collider and collidee objects:
        -- changePairColor({pairHandles[1],pairHandles[2]},collisionColors)
    end
end

function sysCall_cleanup()
    restorePairColor()
end
