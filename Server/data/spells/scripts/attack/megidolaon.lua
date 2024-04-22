-- Used Eternal Winter as a base

-- First wave of damage
local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat1:setArea(createCombatArea(AREA_CIRCLE2X2))

-- Second wave of damage
local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat2:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 5.5) + 25
	local max = (level / 5) + (magicLevel * 11) + 50
	return -min, -max
end

combat1:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function castSecontWave(creature, variant)
	combat2:execute(creature, variant)
end

function castFullSpell(creature, variant)
	combat1:execute(creature, variant)
	addEvent(castSecontWave, 500, creature, variant) -- Cast second wave after .5 sec
end

function onCastSpell(creature, variant)
	return castFullSpell(creature, variant)
end