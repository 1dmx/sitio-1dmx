YTPlayer = (container, id)->
	@container = container
	self = this
	opts =
		height: '600'
		width: '800'
		videoId: id
		events:
			onReady: (evt)-> self.ready(evt)
			onStateChange: (evt)-> self.status(evt)

	@player = new YT.Player(@container.attr('id'), opts)
	@evts = {}

	$w.on('resize', -> self.resize());
	this

YTPlayer::on = (evt, cb)->
	@evts[evt] ||= []
	@evts[evt].push cb

YTPlayer::trigger = (evt, data)->
	
	for cb in @evts[evt]
		#console.log cb
		cb(data)

	return evt

YTPlayer::ready = (evt)->
	#console.log('ready', @container)
	@resize()
	@player.playVideo() unless movil

YTPlayer::resize = ()->
	full = 
		width: $w.width(),
		height: $w.height()

	@container.css full
	$('iframe#timer').css full

YTPlayer::status = (evt)->
	#console.log(evt.data==YT.PlayerState.ENDED)
	if evt.data == YT.PlayerState.ENDED
		@trigger 'ended'
	if evt.data == YT.PlayerState.CUED
		@trigger 'cued'
		@player.playVideo() unless movil

movil = window.navigator.userAgent.match(/mobile/i)
$w = $(window)
window.YTPlayer = YTPlayer;