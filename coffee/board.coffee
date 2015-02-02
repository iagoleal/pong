class window.Board

	canvas: null
	context: null

	bgColor: "#000000"
	fps: 0

	length: 0
	u: 0

	balls: null
	players: null

	mouse: null

	constructor: (cv) ->
		@canvas = cv
		@context = @canvas.getContext "2d"
		@length = 600

		@setSize()


		@mouse =
			pressed: false
			x: 0
			y: 0


		#Objects creation
		@balls = []
		
		@balls.push new Ball {x:(@length/2), y:(@length/2)}, @length/100


		@players = []
		@players.push new Player "player", {x:0, y: (@length/2)}, @length/4
		@players.push new Player "computer", {x: @length, y: (@length/2)}, @length/4

		#Startgame
		@start()

	setSize: () ->
		@canvas.width = @length
		@canvas.height = @length

		# Making canvas square
		if window.innerWidth < window.innerHeight
			@canvas.style.width = window.innerWidth*0.99 + 'px'
			@canvas.style.height = window.innerWidth*0.99 + 'px'
			@u = @length/(window.innerWidth*0.99)
		else
			@canvas.style.width = window.innerHeight*0.99 + 'px'
			@canvas.style.height = window.innerHeight*0.99 + 'px'
			@u = @length/(window.innerHeight*0.99)

		@canvas.style.width = @length

	start: () ->
		for ball in @balls
			ball.start()

	collision: (b) ->
		switch
			when b.r.x + b.v.x <= 0
				if b.r.y <= @players[0].r.y + @players[0].height/2 and b.r.y >= @players[0].r.y - @players[0].height/2
					@players[0].color = b.color
					b.v.x *= -1
					b.v.y += @players[0].v
				else
					@players[1].points++
					@balls.splice @balls.indexOf(b), 1

			when b.r.x + b.v.x >= @length
				if b.r.y <= @players[1].r.y + @players[1].height/2 and b.r.y >= @players[1].r.y - @players[1].height/2
					@players[1].color = b.color
					b.v.x *= -1
					b.v.y += @players[1].v
				else
					@players[0].points++
					@balls.splice @balls.indexOf(b), 1

			when b.r.y + b.v.y <= 0 or b.r.y + b.v.y >= @length
				b.v.y *= -1	

	animate: () ->
		if @mouse.pressed
			p = if @mouse.x < @length/2 then 0 else 1
			mod = if @mouse.y < @players[p].r.y then -1 else 1
			@players[p].v += mod*@length/200
		for player in @players
			player.move(@balls) if player.type is "computer"
			player.go(@length)

		if @balls.length is 0
			@balls.push new Ball {x:(@length/2), y:(@length/2)}, @length/100
			@balls[0].start()

		for ball in @balls
			@collision ball
			ball.go()



	draw: () ->
		@context.fillStyle = @bgColor
		@context.fillRect 0, 0, @length, @length

		@context.shadowBlur = 0
		@context.shadowOffsetX = 0


		# Field lines
		@context.strokeStyle = "white"
		@context.lineWidth = 2

		@context.beginPath()
		@context.moveTo @length/2, 0
		@context.lineTo @length/2, @length
		@context.stroke()
		@context.closePath()

		@context.beginPath()
		@context.arc @length/2, @length/2, @length/13, 0, 2*Math.PI
		@context.stroke()
		@context.closePath()

		#Score
		@context.fillStyle = "#ccc"
		@context.font = "#{@length/5}px Lucida Console"
		@context.textAlign = "center"
		@context.textBaseline = "middle"
		@context.fillText @players[0].points.toString(), @length/4, @length/2, @length/2
		@context.fillText @players[1].points.toString(), (3/4)*@length, @length/2, @length/2

		@context.font = "bold 100% Lucida Console"
		@context.fillText @fps, @length/10, @length/10
		#Objects
		for ball in @balls
			ball.draw @context
		for player in @players
			player.draw @context