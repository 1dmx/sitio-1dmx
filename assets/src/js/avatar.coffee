#= require _jquery

$ ()->
	$canvas = $('canvas')
	$canvas.width(500);
	$canvas.height(500);
	$fbButton = $('#facebook')
	$uploadPhoto = $('#upload-photo');
	$fileUpload = $('#file-upload')
	$controls = $('#snap-controls').hide()
	$canvas.hide();

	$pictures = $('#pictures')
	$block = $('#block');
	$save = $('#save');
	$saveToFB = $('#save-to-facebook');
	$snap = $('#snap')

	canvas = $canvas.get(0)
	canvas.width = 500;
	canvas.height = 500;
	ctx = canvas.getContext('2d');

	dataURItoBlob = (uri)->
		byteString = window.atob(uri.split(',')[1]);
		ab = new ArrayBuffer(byteString.length);
		ia = new Uint8Array(ab);
		console.log(byteString.length)
		for i in [0..byteString.length]
			ia[i] = byteString.charCodeAt(i)
		return new Blob([ab], { type: 'image/png' });

	toImage = ()->
		ctx.fillStyle = 'black'
		ctx.fillRect(parseInt($block.css('left')), parseInt($block.css('top')), $block.width(), $block.height())
		return canvas.toDataURL("image/png")

	$save.on 'click', (evt)->
		this.href = toImage()
	
	postToFacebook = ()->
		FB.getLoginStatus (res)->
			if res.authResponse
				blob = dataURItoBlob(toImage());
				fd = new FormData()
				access_token = res.authResponse.accessToken
				fd.append('access_token', access_token)
				fd.append("message","#CensuraMEXta http://op1d.mx/censuramexta")
				fd.append('source', blob, 'CensuraMEXta.png')
				opts = 
					url: "https://graph.facebook.com/me/photos?access_token=#{access_token}"
					type: 'post'
					data: fd
					processData: false
					contentType: false

				req = $.ajax opts
				req.done (data)->
					if (confirm('Ya está tu foto en Facebook, ¿deseas verla?'))
						window.location.href = "https://facebook.com/#{data.id}"
			else
				return FB.login postToFacebook, {scope:'user_photos,publish_stream'}

	$saveToFB.on 'click', (evt)->
		evt.preventDefault()
		postToFacebook()

	show = (el)->
		$canvas.show();
		$controls.show()
		img = new Image
		console.log video
		maxW = Math.max 500, (video.videoWidth if video)
		maxH = Math.max 500, (video.videoHeight if video)

		$canvas.width(Math.min maxW, $(window).width()-20)
		$canvas.height(Math.min maxH, $(window).height()-20)
		img.onload = ()->
			cw = $canvas.width()
			ch = $canvas.height()
			startX = 0
			startY = 0
			if img.width > img.height
				width = cw
				height = Math.round img.height*cw/img.width
				startY = ch/2-height/2
			else if img.width < img.height
				height = ch
				width = Math.round img.width*ch/img.height
				startX = cw/2-width/2
			else
				width = cw
				height = ch

			canvas.width = width;
			canvas.height = height;
			ctx.width = width
			ctx.height = height
			$canvas.width(width);
			$canvas.height(height);
			$('#editing-area').width(canvas.width)

			ctx.drawImage(el, 0,0, width, height);
			ctx.font = "50px gunplay"

			textOffset = 50
			textOffset = startY+50 if startY > 0
			textX = canvas.width/2-100

			ctx.lineWidth = 4
			ctx.strokeText("1dmx.org", textX, canvas.height-50)
			ctx.fillStyle = "white"
			ctx.fillText("1dmx.org", textX, canvas.height-50)

			
		img.crossOrigin = 'http://profile.ak.fbcdn.net/crossdomain.xml' if el.src.match(/facebook/)
		img.src = el.src
	
	$canvas.on 'mousedown touchstart', (evt)->
		evt.preventDefault();
		return true if evt.button == 2
		$block.width(10);
		$block.height(10);
		startX = evt.offsetX || evt.originalEvent.layerX;
		startY = evt.offsetY || evt.originalEvent.layerY;
		console.log(startX, startY)
		$block.css('left', startX)
		$block.css('top', startY)

		moveBlock = (evt)->
			#evt.preventDefault();
			offX = evt.offsetX || evt.originalEvent.layerX;
			offY = evt.offsetY || evt.originalEvent.layerY;
			$block.width(offX-startX);
			$block.height(offY-startY);

		$canvas.on 'mousemove touchmove', moveBlock
		
		$canvas.on 'mouseup touchend', (evt)->
			$canvas.off('mousemove touchmove', moveBlock);

	videoTO = null
	drawVideo = (evt)->
		video = $video.get(0)
		canvas.width = video.videoWidth;
		canvas.height = video.videoHeight;
		$canvas.width(canvas.width);
		$canvas.height(canvas.height);
		$('#editing-area').width(canvas.width)
		ctx.width = canvas.width;
		ctx.height = canvas.height;
		try
			#console.log('canvas!')
			ctx.drawImage(video, 0, 0, canvas.width, canvas.height)
			videoTO = setTimeout(drawVideo, 20)
		catch err
			if err.name == 'NS_ERROR_NOT_AVAILABLE'
				console.log('retry')
				videoTO = setTimeout(drawVideo, 1000)
			else
				throw err
		

	startVideo = (mediaStream)->
		$controls.show()
		$snap.show();
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		video = $video.get(0)
		video.src = window.URL.createObjectURL(mediaStream)
		video.play();
		video.addEventListener 'loadedmetadata', (evt)->
			$canvas.show();
			canvas.width = video.videoWidth;
			canvas.height = video.videoHeight;
			$canvas.width(canvas.width);
			$canvas.height(canvas.height);
			$('#editing-area').width(canvas.width)
			ctx.width = canvas.width;
			ctx.height = canvas.height;

		video.addEventListener 'playing', drawVideo

	$fileUpload.css({
		width: 0,
		height: 0,
		overflow: 'hidden',
		position: 'absolute',
		left: '-99em';
	}).on 'change', (evt)->
		files = evt.target.files || evt.dataTransfer.files;
		file = files[0]
		unless (/^image/.test file.type)
			alert('¿Estás seguro de que seleccionaste una imagen?')
			return $fileUpload.click();

		url = window.URL.createObjectURL(file)
		img = new Image
		img.src = url
		$('.selected-pic').removeClass('selected-pic');
		img.className = 'selectable-pic selected-pic'
		$pictures.prepend(img)
		show img

	$uploadPhoto.on 'click', (evt)->
		evt.preventDefault();
		$fileUpload.click();


	$snap.hide()
	stopped = false;
	video = null
	navigator.userMedia = (navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia)
	if (navigator.userMedia)
		$video = $('<video>');
		$('body').append($video);
		$video.hide();
		$canvas.before($video)
		$('#take-photo').on 'click', (evt)->
			evt.preventDefault();
			navigator.userMedia {video: true}, startVideo, (err)-> console.log err

		$snap.on 'click', (evt)->
			video = $video.get(0)
			evt.preventDefault()
			if (stopped)
				stopped = false
				video.play()
			else
				stopped = true
				video.pause()
				img = new Image
				img.src = canvas.toDataURL('image/png');
				$('.selected-pic').removeClass('selected-pic');
				img.className = 'selectable-pic selected-pic'
				$pictures.prepend(img)
				clearTimeout videoTO
				videoTO = null
				setTimeout ->show img, 100
	else
		$('#take-photo').hide();

	$pictures.on 'click', '.selectable-pic:not(.selected-pic)', (evt)->
		evt.preventDefault();
		$('.selected-pic').removeClass('selected-pic');
		$(this).addClass('selected-pic');
		$block.width(0);
		$block.height(0);
		show(this);

	selector = (photos)->
		str = ''
		for index, photo of photos
			str += "<img class=\"selectable-pic\" crossorigin='http://profile.ak.fbcdn.net/crossdomain.xml' src=\"#{photo}\" />"
		
		$pictures.html(str);
		first = $pictures.children().first()
		first.addClass('selected-pic')
		show(first.get(0))

	auth = {}
	auth.facebook = (res)->
		if res.authResponse
			FB.api '/me/albums', (res)->
				album = null
				for index,a of res.data 
					album = a if a.type is 'profile'
				
				FB.api "/#{album.id}/photos", (res)->
					data = []
					for index, pic of res.data
						data.push(pic.images[0].source)	

					selector(data)				

	$fbButton.on 'click', (evt)->
		clearTimeout videoTO
		$snap.hide()
		evt.preventDefault();
		FB.getLoginStatus (res)->
			return auth.facebook(res) if res.status is 'connected'
			return FB.login auth.facebook, {scope:'user_photos,publish_stream'}
		return false

	return