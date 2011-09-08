package com.emirates.emiratesIn.controller.signals
{
	import com.emirates.emiratesIn.vo.ResultQualativeAnswerVO;

	import org.osflash.signals.Signal;

	/**
	 * @author Fraser Hobbs
	 */
	public class AnswersCompleteSignal extends Signal
	{
		public function AnswersCompleteSignal()
		{
			super(Vector.<ResultQualativeAnswerVO>);
		}
	}
}
