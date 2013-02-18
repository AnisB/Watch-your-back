
world = nil

PhysicsComponent = {}

PhysicsComponent['ShapeType'] = { C=1, R=3 }

PhysicsComponent.__index = PhysicsComponent


function PhysicsComponent.new(shape_type, x, y, isStatic, options)
	local pc = {}						 -- our new object
	setmetatable(pc, PhysicsComponent)	-- make PhysicsComponent handle lookup
	local width, height
	if shape_type == PhysicsComponent.ShapeType.C then
		pc.shape = love.physics.newCircleShape(options.r)
		height = options.r
		width = options.r
		x = x + options.r
		y = y - options.r
	elseif shape_type == PhysicsComponent.ShapeType.R then
		pc.shape = love.physics.newRectangleShape(options.width, options.height)
		height = options.height
		width = options.width
		x = (width+x*2)/2
		y = y+height/2
	else -- If not in the constants. return nil together with an error
		print "ERROR, wrong shape_type passed to PhysicsComponent"
		print ("Value passed: " .. shape_type)
		return nil
	end

	if isStatic == true then
		pc.body = love.physics.newBody(world, x, y)
	else
		pc.body = love.physics.newBody(world, x, y, "dynamic")
	end

	pc.fixture = love.physics.newFixture(pc.body, pc.shape, 1) -- Attach fixture to body and give it a density of 1 (rigid body)
	pc.body:setFixedRotation(true)
	pc.fixture:setFriction(0.0)
	pc.body:setInertia(0.0)

	return pc
end
function PhysicsComponent:reset()
PhysicsComponent['ShapeType'] = { C=1, R=3 }
end

