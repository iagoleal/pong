class window.Player
	r: null
	height: 0

	v: 0
	a: 0
	
	type: null
	side: null
	points: 0

	color: null

	constructor: (@type="player", p={x:0, y:0}, @height=1) ->
		@r =
			x: p.x
			y: p.y
		@color =
			r: Math.round(Math.random()*255)
			g: Math.round(Math.random()*255)
			b: Math.round(Math.random()*255)

	move: (balls) ->
		ball = null
		for b in balls
			if (not ball?) or Math.abs(@r.y - b.r.y) < Math.abs(@r.y - ball.r.y)
				ball = b
		if ball
			if ball.r.y - @r.y > 0
				@v += @height/100
			else if ball.r.y - @r.y < 0
				@v -= @height/100

	go: (l) ->
		@v *= 0.9

		if (@r.y - @height/2) + @v <= 0 
			@v = 0 
			@r.y = @height/2
		else if(@r.y + @height/2) + @v >= l
			@v = 0
			@r.y = l - @height/2
		else
			@r.y += @v

	draw: (c) ->
		c.lineCap = "round"
		#http://www.ashleysheridan.co.uk/coding/javascript/Animated+Glowing+Lines+in+Canvas
		for i in [5..0]
			c.lineWidth = (i+1)*5-2
			color = if i is 0 then '#fff' else "rgba(#{@color.r}, #{@color.g}, #{@color.b}, 0.2)"
			c.strokeStyle = color

			q = if i is 0 then 0 else (5-i)*@height*0.05

			c.beginPath()
			c.moveTo @r.x, @r.y - @height/2 + q
			c.lineTo @r.x, @r.y + @height/2 - q
			c.stroke()
			c.closePath()

		