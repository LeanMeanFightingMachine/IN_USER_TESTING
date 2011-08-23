package com.emirates.emiratesIn.controller.signals
{
	import com.emirates.emiratesIn.vo.ResultVO;
	import org.osflash.signals.Signal;

	/**
	 * @author Fraser Hobbs
	 */
	public class TestUpdateSignal extends Signal
	{
		public function TestUpdateSignal()
		{
			super(ResultVO);
		}
	}
}
