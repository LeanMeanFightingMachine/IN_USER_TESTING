package com.emirates.emiratesIn.model
{
	import com.emirates.emiratesIn.controller.signals.NextTestSignal;
	import com.emirates.emiratesIn.enum.Config;
	import com.emirates.emiratesIn.utils.ArrayUtil;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author Fraser Hobbs
	 */
	public class TestModel extends Actor
	{
		[Inject]
		public var nextTestSignal:NextTestSignal;
		
		private var _order:Array = [];
		
		public function reset():void
		{
			_order = [];
			
			for (var i : int = 0; i < Config.TESTING_TESTS.length; i++)
			{
				for (var j : int = 0; j < Config.TESTING_HOLD.length; j++)
				{
					_order.push([Config.TESTING_TESTS, Config.TESTING_HOLD]);
				}
			}
			
			ArrayUtil.shuffle(_order);
		}
		
		public function next():void
		{
			if(_order.length > 0)
			{
				nextTestSignal.dispatch(_order.pop());
			}
			else
			{
				nextTestSignal.dispatch(_order.pop());
			}
		}
	}
	
	
}
