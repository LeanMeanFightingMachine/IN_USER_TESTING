package com.emirates.emiratesIn.model
{
	import com.emirates.emiratesIn.enum.Test;
	import com.emirates.emiratesIn.controller.signals.NoTestsSignal;
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import com.emirates.emiratesIn.vo.TestVO;
	import com.emirates.emiratesIn.controller.signals.GotNextTestSignal;
	import com.emirates.emiratesIn.enum.Config;
	import com.emirates.emiratesIn.utils.ArrayUtil;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author Fraser Hobbs
	 */
	public class TestingModel extends Actor
	{
		[Inject]
		public var nextTestSignal:GotNextTestSignal;
		
		[Inject]
		public var noTestsSignal:NoTestsSignal;
		
		private var _order:Array = [];
		
		public function reset():void
		{
			_order = [];
			
			var testVO:TestVO = new TestVO();
			
			for (var i : int = 0; i < Config.TESTING_TESTS.length; i++)
			{
				for (var j : int = 0; j < Config.TESTING_HOLD.length; j++)
				{
					var st : int = 0;
					if (Config.TESTING_TESTS[i] == Test.ENTRY) st = 1;
					
					for (var k : int = st; k < Config.TESTING_LEVELS; k++)
					{
						for (var l : int = 0; l < 2; l++)
						{
							testVO = new TestVO();
							testVO.type = Config.TESTING_TESTS[i];
							testVO.hold = Config.TESTING_HOLD[j];
							testVO.adjust = k * Config.TESTING_INCREMENT;
							testVO.level = k;
							testVO.feedback = (l == 0);
							_order.push(testVO);
						}
					}
				}
			}
			
			Debug.log("No. tests: " + _order.length);
			
			ArrayUtil.shuffle(_order);
			
			Debug.log("TestingModel reset");
		}
		
		public function next():void
		{
			Debug.log("TestingModel next");
			
			if(_order.length > 0)
			{
				nextTestSignal.dispatch(_order.pop());
			}
			else
			{
				noTestsSignal.dispatch();
			}
		}
	}
	
	
}
