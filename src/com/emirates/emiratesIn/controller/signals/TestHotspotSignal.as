package com.emirates.emiratesIn.controller.signals
{
	import com.emirates.emiratesIn.vo.HotspotVO;
	import org.osflash.signals.Signal;

	/**
	 * @author Fraser Hobbs
	 */
	public class TestHotspotSignal extends Signal
	{
		public function TestHotspotSignal()
		{
			super(HotspotVO);
		}
	}
}
