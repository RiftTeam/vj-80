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
	return PALETTES[index]
end

function getPaletteIDByIndex(index)
	return PALETTES[index].id
end

function getPaletteIDs()
	return PALETTE_IDS
end

function getPaletteCount()
	return #PALETTES
end