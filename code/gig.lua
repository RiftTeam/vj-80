-- ========
-- EFFECTS
-- effects follow the template: {boot=function(), draw=function(), bdr=function()}

local EFFECTS = {}
local EFFECT_IDS = {}

-- Send in a table of effect objects (this will probably be a list of requires)
function setEffects(effects)
	EFFECTS = effects
end

function bootEffects()
	for i,effect in ipairs(EFFECTS) do
		if effect.boot then
			effect.boot()
		end
		table.insert(EFFECT_IDS, effect.id)
	end
end

function getEffectByIndex(index)
	return EFFECTS[index]
end

function getEffectIDByIndex(index)
	return EFFECTS[index].id
end

function getEffectIndexByID(id)
	for i,effect in ipairs(EFFECTS) do
		if effect.id == id then
			return i
		end
	end
	return 0
end

function getEffectIDs()
	return EFFECT_IDS
end

function getEffectCount()
	return #EFFECTS
end

-- ========
-- OVERLAYS
-- overlays follow the template: {id='', boot=function(), draw=function(), bdr=function()}

local OVERLAYS = {}
local OVERLAY_IDS = {}

-- Send in a table of overlay objects (this will probably be a list of requires)
function setOverlays(overlays)
	OVERLAYS = overlays
end

function bootOverlays()
	for i,overlay in ipairs(OVERLAYS) do
		if overlay.boot then
			overlay.boot()
		end
		table.insert(OVERLAY_IDS, overlay.id)
	end
end

function getOverlayByIndex(index)
	return OVERLAYS[index]
end

function getOverlayIDByIndex(index)
	return OVERLAYS[index].id
end

function getOverlayIndexByID(id)
	for i,overlay in ipairs(OVERLAYS) do
		if overlay.id == id then
			return i
		end
	end
	return 0
end

function getOverlayIDs()
	return OVERLAY_IDS
end

function getOverlayCount()
	return #OVERLAYS
end

-- =========
-- MODIFIERS

local MODIFIERS = {}
local MODIFIER_IDS = {}

-- Send in a table of overlay objects (this will probably be a list of requires)
function setModifiers(modifiers)
	MODIFIERS = modifiers
end

function bootModifiers()
	for i,modifier in ipairs(MODIFIERS) do
		if modifier.boot then
			modifier.boot()
		end
		table.insert(MODIFIER_IDS, modifier.id)
	end
end

function getModifierByIndex(index)
	return MODIFIERS[index]
end

function getModifierIDByIndex(index)
	return MODIFIERS[index].id
end

function getModifierIndexByID(id)
	for i,modifier in ipairs(MODIFIERS) do
		if modifier.id == id then
			return i
		end
	end
	return 0
end

function getModifierIDs()
	return MODIFIER_IDS
end

function getModifierCount()
	return #MODIFIERS
end

-- ========
-- PALETTES

local PALETTES = {}
local PALETTE_IDS = {}

-- Send in a table of palette objects (this will probably be a list of requires)
function setPalettes(palettes)
	PALETTES = palettes
end

function bootPalettes()
	for i,palette in ipairs(PALETTES) do
		if palette.boot then
			palette.boot()
		end
		table.insert(PALETTE_IDS, palette.id)
	end
end

function getPaletteByIndex(index)
	return PALETTES[index + 1]
end

function getPaletteIDByIndex(index)
	return PALETTES[index + 1].id
end

function getPaletteIndexByID(id)
	for i,palette in ipairs(PALETTES) do
		if palette.id == id then
			return i-1
		end
	end
	return 0
end

function getPaletteIDs()
	return PALETTE_IDS
end

function getPaletteCount()
	return #PALETTES
end