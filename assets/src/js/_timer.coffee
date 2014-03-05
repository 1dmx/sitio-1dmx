pad = (str, len=2)->
	str = str+''
	while str.length < len
		str = "0#{str}"
	str

Timer = (time, opts)->
	@opts =
		tick: 1000
	
	@opts.ms = @opts.tick<1000
	@timeout = null;
	@cbs = [];

	if time instanceof Date
		@until = time
	else
		@until = ()=>
			@started + time*1000

	this

Timer::onTick = (cb)->
	@cbs.push cb

Timer::notify = (h,m,s,ms, ended)->
	ms = ''
	ms = ".#{pad ms, 3}" if @opts.ms
	str = "#{pad h}:#{pad m}:#{pad s}#{ms}"
	for cb in @cbs
		cb(str, ended)

Timer::tick = ()->
	diff = @until-(new Date()).getTime()
	diffSegundos = Math.floor(diff/1000)

	ms = diff%1000

	endCheck = diff
	endCheck = diffSegundos unless @opts.ms

	h = Math.floor diffSegundos/60/60
	m = Math.floor diffSegundos/60 - h*60
	s = diffSegundos%60;
	if endCheck > 0
		@timeout = setTimeout =>
				@tick()
			,
			@opts.tick
	else
		ended = true
		h = 0;
		m = 0;
		ms = 0;
		s = 0;

	@notify(h,m,s,ms, ended)


Timer::stop = ()->
	@stopped = true
	clearTimeout(@timeout)

Timer::start = ()->
	return if @stopped
	@started = new Date().getTime()
	if typeof @until == 'function'
		@until = @until()

	#console.log @started, @until
	@timeout = setTimeout =>
			@tick()
		,
		@opts.tick


window.Timer = Timer