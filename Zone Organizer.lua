--note: when making changes to this zone, often an extra zone is created. make sure to delete it

local zone = self
local zoneSetup = false

function onload()
    createButtons()
end

function onDestroy()
    if zone ~= self then
        destroyObject(zone)
    end
end

function onCollisionEnter(collision_info)
    if not zoneSetup then
        doLayout()
    end
end

function onPickUp()
    if zone ~= self then
        destroyObject(zone)
        zoneSetup = false
    end
end

function createButtons()
    self.createButton({
        label='Layout',
        click_function='doLayout',
        function_owner=self,
        position={0,1,-0.55},
        rotation={0,180,0},
        scale={0.5,0.5,0.25},
        color={r=0, g=64, b=0},
        width=800,
        height=100,
        font_size=100
    })
end

function doLayout(obj, color)
    updateZone()
    Wait.frames(function() zone.LayoutZone.layout() end, 5)
end

function updateZone()
    scale = self.getScale()
    pos = self.getPosition()
    
    if not zoneSetup then
        zone = spawnObject({ type="LayoutZone" })
        Wait.frames(configureZone, 5)
        zoneSetup = true
    end
    
    zone.setScale({scale.x, scale.y+3, scale.z*2})
    zone.setPosition({pos.x, pos.y+1, pos.z})
    zone.setRotation(self.getRotation())
end

function configureZone()
    zone.LayoutZone.setOptions({
        trigger_for_face_up=true,
        trigger_for_face_down=true,
        trigger_for_non_cards=false,
        split_added_decks=true,
        combine_into_decks=false,
        cards_per_deck=0,
        direction=1,
        new_object_facing=0,
        horizontal_group_padding=0.0,
        vertical_group_padding=0.0,
        sticky_cards=false,
        randomize=false,
        instant_refill=true,
        manual_only=false,
        meld_direction=3,
        meld_sort=1,
        meld_reverse_sort=false,
        meld_sort_existing=true,
        horizontal_spread=0,
        vertical_spread=0.5,
        max_objects_per_new_group=999999,
        alternate_direction=false,
        max_objects_per_group=999999,
        allow_swapping=true
    })
end