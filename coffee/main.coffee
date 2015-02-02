window.onload = () ->
	window.board = new Board document.getElementById("board")

	draw()
	animate()

	window.onresize = () ->
		board.setSize() if board

	window.onkeydown = (e) ->
		if board.players[0].type is "player"
			if e.keyCode == 83
				board.players[0].v += board.players[0].height/10
			if e.keyCode == 87
				board.players[0].v -= board.players[0].height/10
		if board.players[1].type is "player"
			if e.keyCode == 40
				board.players[1].v += board.players[1].height/10
			if e.keyCode == 38
				board.players[1].v -= board.players[1].height/10

	document.getElementById("board").onmousedown = (e) ->
		board.mouse.pressed = true
	document.getElementById("board").onmouseup = (e) ->
		board.mouse.pressed = false

	document.getElementById("board").onmousemove = (e) ->
		board.mouse.x = (e.pageX - board.canvas.offsetLeft)*board.u
		board.mouse.y = (e.pageY - board.canvas.offsetTop)*board.u
		#console.log board.mouse.x, board.mouse.y

animate = () ->
	window.board.animate()
	
	window.setTimeout animate, 1000/60


draw = () ->
	if typeof draw.lastTime is 'undefined'
		draw.lastTime = new Date().getTime()
	else
		fps = 1000/(new Date().getTime() - draw.lastTime)
		board.fps = fps.toFixed(2) + ' fps'
		draw.lastTime = new Date().getTime()

	window.board.draw()

	requestAnimationFrame(draw)


window.requestAnimationFrame = do ->
	window.requestAnimationFrame or
	window.webkitrequestAnimationFrame or
	window.mozrequestAnimationFrame or
	(cback) -> window.setTimeout cback, 1000/60