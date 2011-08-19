package com.emirates.emiratesIn.model
{
	import com.emirates.emiratesIn.controller.signals.AttentionUpdatedSignal;
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fraserhobbs
	 */
	public class AttentionModel extends Actor
	{
		private var _current:int;
		private var _total:Number = 0;
		private var _count:int;
		private var _history : Vector.<int> = new Vector.<int>();
		
		[Inject]
		public var attentionUpdatedSignal:AttentionUpdatedSignal;
		
		public function AttentionModel()
		{
		}
		
		public function add(value:int):void
		{
			process(value);
			
			attentionUpdatedSignal.dispatch(value);
		}
		
		public function getAverage() : Number
		{
			return _total / _count;
		}

		public function getSampleAverage(size:int) : Number
		{
			var total:Number = 0;
			var i:int = 0;
			while (i < _history.length && i < size)
			{
				total += _history[i];
			}

			return total / i;
		}
		
		private function process(value : int) : void
		{
			_current = value;

			_total += value;
			_count++;
			
			_history.push(value);
		}
	}
}
