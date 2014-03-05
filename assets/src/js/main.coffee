#= require _jquery
#= require _timer
#= require _ytplayer

$ ()->
	
	timerEl = $ '#timer'
	player = null

	if (timerEl.length > 0)
		
		timer = new Timer 10
		videoEnded = (evt)->
			timer.stop()
			evt.preventDefault() if evt and evt.preventDefault
			$('#video').slideUp(500, ()->
				now = new Date()
				un_año = 31536000
				expires = new Date(now.getTime()+un_año)
				document.cookie = "guachado=true; expires #{expires}; path=/"
				$('#content').show();
				timerEl.remove();
			);
		$('#saltar-video').click(videoEnded)

		timer.opts.tick = 100
		timer.onTick (str, ended)->
			timerEl.text str
			if ended
				$('#video h1').slideUp(100);
				player = new YTPlayer(timerEl, 'm2zpjJteZPI')
				player.on 'cued', ()->
					#console.log 'cued'
				player.on 'ended', videoEnded

		timer.start()


	comunicado = $ '#comunicado-body p'
	parrafos = []
	comunicado.each (index, element)->
		this.id = "parrafo-#{index}"
		parrafos.push element.innerText.split(/\s/)

	array_random = (a)->
		Math.floor(Math.random()*a.length)


	palabras_censuradas = 5
	censura = (id, menos=false)->
		parrafo = parrafos[id]

		if menos
			prohibidos = [menos..menos+palabras_censuradas]
			index = array_random(parrafo)
			while prohibidos.indexOf(index) > 0
				index = array_random(parrafo) 
		else
			index = array_random(parrafo)

		
		start = parrafo.slice(0, index).join(' ');
		redacted = parrafo.slice(index, index+palabras_censuradas);
		end = parrafo.slice(index+palabras_censuradas, parrafo.length).join(' ')
		redacted = "<span class=\"censurado\" data-index=\"#{index}\">#{redacted.join(' ')}</span>"
		$("#parrafo-#{id}").html("#{start} #{redacted} #{end}");


	comunicado.on 'mouseover click', '.censurado', (evt)->
		r = $(this)
		p = r.parent()
		index = parseInt r.data('index'), 10
		r.removeClass('censurado');
		id = parseInt p.attr('id').replace(/\D+/, ''), 10
		setTimeout ()->
				censura(id, index)
			,500
		true

	for id,parrafo of parrafos
		censura(id)


