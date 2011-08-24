package com.emirates.emiratesIn.model
{
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
		
		public function ResultsModel()
		{
			
		}
		
		public function add():void
		{
			_result = new ResultVO();
			_results.push(_result);
		}
		
		public function addAttention():void
		{
			
		}
		
		public function addAnswer(question:int, answer:int):void
		{
			var an : ResultQualativeAnswerVO = new ResultQualativeAnswerVO();
			an.questionID = question;
			an.answerID = answer;
			_result.qualative.answers.push(an);
		}
		
		public function set type(value:String):void
		{
			_result.type = value;
		}
		
		public function set level(value:int):void
		{
			_result.level = value;
		}
		
		public function set hold(value:int):void
		{
			_result.hold = value;
		}
		
		public function set position(value:int):void
		{
			_result.position = value;
		}
		
		public function set target(value:int):void
		{
			_result.target = value;
		}
	}
}
