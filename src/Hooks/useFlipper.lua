local Flipper = require(script.Parent.Parent.import)("Flipper")
local AssignedBinding = require(script.Parent.Parent.AssignedBinding)

local function createUseFlipper(motor, useBinding)
	local isMotor = Flipper.isMotor(motor)
	if not isMotor then
		error("Provided value is not a motor!", 2)
	end

	if motor[AssignedBinding] then
		return motor[AssignedBinding]
	end

	local binding, setBindingValue = useBinding(motor:getValue())
	motor:onStep(setBindingValue)

	motor[AssignedBinding] = binding

	return binding, motor
end

local function useFlipper(motor)
	return function(hooks)
        	return createUseFlipper(motor, hooks.useBinding)
	end
end

return useFlipper