function setEffect(id, config)
    Effect = getEffectIndexByID(id)
    ETimerMode = config.timerMode
    EDivider = config.divider
    EPalette = getPaletteIndexByID(config.palette)
    EStutter = config.stutter
    EModifier = getModifierIndexByID(config.modifier)
    EMControl = config.modControl
    EMTimerMode = config.modTimerMode
    EMDivider = config.modDivider
    ECLS = config.cls
  end
  
  function setOverlay(id, config)
    Overlay = getOverlayIndexByID(id)
    OTimerMode = config.timerMode
    ODivider = config.divider
    OControl = config.control
    OPalette = getPaletteIndexByID(config.palette)
    OStutter = config.stutter
    OModifier = getModifierIndexByID(config.modifier)
    OCLS = config.cls
  end
  
  SHORTCUTS={}
  function setNumberShortcut(number, fn)
    SHORTCUTS[number] = fn
  end
  
  function triggerNumberShortcut(number)
    if SHORTCUTS[number] ~= nil then
      SHORTCUTS[number]()
    end
  end

--[[
    Something like this might be useful?
EffectState={}
OverlayState={}
State={}

function EffectState:new()
    local o={
        id=nil,
        timerMode=nil,
        divider=nil,
        control=nil,
        palette=nil,
        modifier=nil,
        modTimerMode=nil,
        modDivider=nil,
        stutter=nil,
        cls=nil,
    },

    setmetatable(o,self)
    self.__index=self
    return o
end

function OverlayState:new()
    local o={
        id=nil,
        timerMode=nil,
        divider=nil,
        control=nil,
        palette=nil,
        modifier=nil,
--        modTimerMode=nil,
--        modDivider=nil,
        stutter=nil,
        cls=nil,
    },

    setmetatable(o,self)
    self.__index=self
    return o
end


function State:new(effectState, overlayState)
    local o={
        effect=effectState,
        overlay=overlayState,
    }

    setmetatable(o,self)
    self.__index=self
    return o
end
--]]