package com.emirates.emiratesIn.display.video.events
{
	import flash.events.Event;

	/**
	 * @author fraserhobbs
	 */
	public class VideoPlayerEvent extends Event
	{
		//	----------------------------------------------------------------
		//	CONSTANTS
		//	----------------------------------------------------------------
		public static const PLAYING : String = "VideoPlayerEvent_PLAYING";
		public static const FINISHED : String = "VideoPlayerEvent_FINISHED";
		
		//	----------------------------------------------------------------
		//	CONSTRUCTOR
		//	----------------------------------------------------------------
		public function VideoPlayerEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		//	----------------------------------------------------------------
		//	PUBLIC METHODS
		//	----------------------------------------------------------------
		override public function clone() : Event
		{
			return new VideoPlayerEvent(type,bubbles,cancelable);
		}
	}
}
