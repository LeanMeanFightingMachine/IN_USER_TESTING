package com.emirates.emiratesIn.controller.signals
{
	import org.osflash.signals.Signal;

	/**
	 * @author Fraser Hobbs
	 */
	public class GotNextStateSignal extends Signal
	{
		public function GotNextStateSignal()
		{
			super(String);
		}
	}
}
