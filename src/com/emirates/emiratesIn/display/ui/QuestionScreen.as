package com.emirates.emiratesIn.display.ui
{
	import flash.events.MouseEvent;
	import com.emirates.emiratesIn.vo.ResultQualativeAnswerVO;

	/**
	 * @author fraserhobbs
	 */
	public class QuestionScreen extends Screen
	{
		private var _questions:Vector.<Question> = new Vector.<Question>();
		private var _prompt:Prompt = new Prompt("Please answer all the questions");
		
		public function QuestionScreen()
		{
			super();
			
			addChild(_prompt);
		}
			
		override public function show() : void
		{
			super.show();
			
			for (var i : int = 0; i < _questions.length; i++)
			{
				_questions[i].reset();
			}
		}
		
		public function ask(id:int, question:String, answers:Array):void
		{
			var q:Question = new Question(id, question, answers);
			q.x = 20;
			addChild(q);
			_questions.push(q);
			
			update();
		}
		
		public function get answers():Vector.<ResultQualativeAnswerVO>
		{
			var ans:Vector.<ResultQualativeAnswerVO> = new Vector.<ResultQualativeAnswerVO>();
			var an:ResultQualativeAnswerVO;
			
			for (var i : int = 0; i < _questions.length; i++)
			{
				an = new ResultQualativeAnswerVO();
				an.questionID = _questions[i].id;
				an.answerID = _questions[i].answer;
				ans.push(an);
			}
			
			return ans;
		}
			
		override protected function draw() : void
		{
			super.draw();
			
			_contentHeight += 20;
			
			for (var i : int = 0; i < _questions.length; i++)
			{
				_questions[i].y = _contentHeight + 20;
				_contentHeight = _questions[i].y + _questions[i].height;
			}
			
			_prompt.x = _button.x + (_button.width * 0.5);
			_prompt.y = _button.y - 10;
		}
		
		private function valid():Boolean
		{
			for (var i : int = 0; i < _questions.length; i++)
			{
				if(_questions[i].answer == -1)
				{
					return false;
				}
			}
			
			return true;
		}
			
		override protected function buttonClickHandler(event : MouseEvent) : void
		{
			if(valid())
			{
				_prompt.hide();
				super.buttonClickHandler(event);
			}
			else
			{
				_prompt.show();
			}
			
		}
	}
}
