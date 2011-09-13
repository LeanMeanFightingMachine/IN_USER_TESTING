package com.emirates.emiratesIn.display.video
{
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import com.emirates.emiratesIn.display.video.events.VideoPlayerEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	/**
	 * @author Fraser Hobbs
	 */
	public class VideoPlayer extends Sprite
	{
		// ----------------------------------------------------------------
		// PRIVATE MEMBERS
		// ----------------------------------------------------------------
		private var _path : String;
		private var _video : Video;
		private var _stream : NetStream;
		private var _connection : NetConnection;
		private var _playing:Boolean = false;
		private var _speed:Number = 1;
		private var _stamp:Number;

		// ----------------------------------------------------------------
		// CONSTRUCTOR
		// ----------------------------------------------------------------
		public function VideoPlayer(path : String = null, width : int = 320, height : int = 240)
		{
			_path = path;
			
			_video = new Video(width, height);
			addChild(_video);

			_connection = new NetConnection();
			_connection.connect(null);

			_stream = new NetStream(_connection);
			_stream.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			_stream.client = new VideoClient();

			_video.attachNetStream(_stream);
			_video.smoothing = true;
		}

		// ----------------------------------------------------------------
		// PUBLIC METHODS
		// ----------------------------------------------------------------
		public function play() : void
		{
			_stamp = getTimer();
			
			if (_path)
			{
				if(!_playing)
				{
					_stream.seek(0);
					_stream.play(_path);
					
					if (_speed != 1)
					{
						_stream.pause();
						addEventListener(Event.ENTER_FRAME, enterFrameHandler);
					}
					
					_playing = true;
				}
				else
				{
					if (_speed == 1)
					{
						_stream.resume();
					}
					addEventListener(Event.ENTER_FRAME, enterFrameHandler);
				}
			}
		}
		
		public function seek(value:Number):void
		{
			_stream.seek(value);
		}
		
		public function speed(value:Number):void
		{
			if (_playing && _speed == 1)
			{
				_stream.resume();
			}
			else
			{
				_stream.pause();
			}

			_speed = value;
		}
		
		public function stop():void
		{
			_stream.pause();
			_stream.seek(0);
		}

		public function pause() : void
		{
			_stream.pause();
			
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public function volume(v:Number):void
		{
			_stream.soundTransform = new SoundTransform(v);
		}
		
		private function finished():void
		{
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				
			dispatchEvent(new VideoPlayerEvent(VideoPlayerEvent.FINISHED));
				
			_playing = false;
		}
		
		//	----------------------------------------------------------------
		//	ACCESSORS
		//	----------------------------------------------------------------
		public function get time():int
		{
			return _stream.time * 1000;
		}
		
		public function set scale(value:Number):void
		{
			scaleX = value;
			scaleY = value;
		}
		
		public function get scale():Number
		{
			return scaleX;
		}

		override public function set width(value : Number) : void
		{
			_video.width = value;
			
			graphics.clear();
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}

		override public function set height(value : Number) : void
		{
			_video.height = value;
			
			graphics.clear();
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
		
		// ----------------------------------------------------------------
		// EVENT HANDLERS
		// ----------------------------------------------------------------
		private function onNetStatus(event : NetStatusEvent) : void
		{
			Debug.log(">>> " + event.info["code"]);
			
			if(event.info["code"] == "NetStream.Play.Start")
			{
				addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
			else if (event.info["code"] == "NetStream.Play.Stop")
			{
				finished();
			}
		}

		private function enterFrameHandler(event : Event) : void
		{
			trace(_stream.time + " : " + _stream.client["duration"]);
			
			if(_stream.client["duration"] > 0 && _stream.time >= _stream.client["duration"])
			{
				finished();
			}
			else
			{
				trace("_speed" + _speed);
				
				if(_speed != 1)
				{
					if(_speed < 1)
					{
						var d:Number = getTimer() - _stamp;
						
						trace(d);
						
						if (d >= _stream.client["frameduration"] / _speed)
						{
							_stamp = getTimer() - (d - (_stream.client["frameduration"] / _speed));
							_stream.seek(_stream.time + (_stream.client["frameduration"] / 1000));
							
							dispatchEvent(new VideoPlayerEvent(VideoPlayerEvent.PLAYING));
						}
						
						
					}
				}
				else
				{
					dispatchEvent(new VideoPlayerEvent(VideoPlayerEvent.PLAYING));
					_stamp = getTimer();
				}
				
				
			}
		}
	}
}
internal class VideoClient
{
	public var duration:int;
	public var framerate:int;
	public var frameduration:Number;
	
	public function onCuePoint(info : Object) : void
	{
		trace("onCuePoint", info);
	}

	public function onMetaData(info : Object) : void
	{
		trace("onMetaData", info);
		
		duration = info["duration"];
		framerate = info["framerate"];
		frameduration = 1000 / framerate;
	}

	public function onXMPData(info : Object) : void
	{
		trace("onXMPData", info);
	}
}