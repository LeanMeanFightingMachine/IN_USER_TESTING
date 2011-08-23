package com.emirates.emiratesIn.controller.signals
{
	import com.emirates.emiratesIn.vo.TestVO;

	import org.osflash.signals.Signal;

	/**
	 * @author Fraser Hobbs
	 */
	public class GotNextTestSignal extends Signal
	{
		public function GotNextTestSignal():void
		{
			super(TestVO);
		}
	}
}
