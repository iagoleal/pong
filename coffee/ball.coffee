class Circle
	r: null # r position vector
	radius: 0

	color: "#ffc821"

	constructor: (p={x:0,y:0}, @radius=1) ->
		@r =
			x: p.x
			y: p.y
		@color =
			r: Math.round(Math.random()*255)
			g: Math.round(Math.random()*255)
			b: Math.round(Math.random()*255)

	draw: (c) ->

		for i in [5..1]
			c.lineWidth = (i+1)*4-2
			color = if i is 0 then '#fff' else "rgba(#{@color.r}, #{@color.g}, #{@color.b}, 0.2)"
			c.strokeStyle = color
			
			q = if i is 0 then 0 else (5-i)*@height*0.05

			c.beginPath()
			c.arc @r.x, @r.y, @radius, 0, 2*Math.PI, false
			c.stroke()
			c.closePath()


		c.beginPath()
		c.arc @r.x, @r.y, @radius, 0, 2*Math.PI, false
		c.closePath()

		c.fill()

class window.Ball extends Circle
	v: null
	speed: 7

	constructor: (p={x:0,y:0}, @radius=1, vel={x:0,y:0}) ->
		super p, @radius

		@v = 
			x: vel.x
			y: vel.y

	start: () ->
		theta = Math.random()*2*Math.PI
		theta = Math.random()*2*Math.PI while theta is Math.PI/2 and theta is (3/2)*Math.PI
		@v.x = @speed*Math.sign(Math.cos(theta))
		@v.y = @speed*Math.sin(theta)

	go: () ->
	
		@r.x += @v.x
		@r.y += @v.y
