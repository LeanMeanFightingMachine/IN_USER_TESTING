package com.emirates.emiratesIn.model
{
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import com.emirates.emiratesIn.vo.ResultAttentionVO;
	import com.emirates.emiratesIn.vo.ResultQualativeAnswerVO;
	import com.emirates.emiratesIn.vo.ResultVO;

	import org.robotlegs.mvcs.Actor;

	/**
	 * @author fraserhobbs
	 */
	public class ResultsModel extends Actor
	{
		private var _results:Vector.<ResultVO> = new Vector.<ResultVO>();
		private var _result:ResultVO;
		private var _position:int;
		
		public function ResultsModel()
		{
			
		}
		
		public function add():void
		{
			Debug.log(">>> ADD <<<");
			
			_result = new ResultVO();
			_result.position = _position;
			_results.push(_result);
			
			_position++;
		}
		
		public function addAttention(value:ResultAttentionVO):void
		{
			_result.quantative.data.push(value);
		}
		
		public function get last():ResultVO
		{
			return _result;
		}
		
		public function set answers(value:Vector.<ResultQualativeAnswerVO>):void
		{
			_result.qualative.answers = value;
		}
		
		public function set feedback(value:Boolean):void
		{
			_result.feedback = value;
		}
		
		public function set startTime(value:int):void
		{
			_result.quantative.startTime = value;
		}
		
		public function set type(value:String):void
		{
			_result.type = value;
		}
		
		public function set level(value:int):void
		{
			_result.level = value;
		}
		
		public function set adjust(value:int):void
		{
			_result.adjust = value;
		}
		
		public function set hold(value:int):void
		{
			_result.hold = value;
		}
		
		public function set completedTime(value:int):void
		{
			_result.quantative.completedTime = value;
		}
		
		public function set target(value:int):void
		{
			_result.quantative.target = value;
		}
	}
}
