package com.emirates.emiratesIn.display.ui.debug.events
{
	import flash.events.Event;

	/**
	 * @author Fraser Hobbs
	 */
	public class ControlsEvent extends Event
	{
		//	----------------------------------------------------------------
		//	CONSTANTS
		//	----------------------------------------------------------------
		public static const FEEDBACK_CHANGED : String = "ControlsEvent_FEEDBACK_CHANGED";
		public static const TRANSITION_CHANGED : String = "ControlsEvent_TRANSITION_CHANGED";
		public static const THRESHOLD_CHANGED : String = "ControlsEvent_THRESHOLD_CHANGED";
		
		//	----------------------------------------------------------------
		//	CONSTRUCTOR
		//	----------------------------------------------------------------
		public function ControlsEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		//	----------------------------------------------------------------
		//	PUBLIC METHODS
		//	----------------------------------------------------------------
		override public function clone() : Event
		{
			return new ControlsEvent(type,bubbles,cancelable);
		}
	}
}
