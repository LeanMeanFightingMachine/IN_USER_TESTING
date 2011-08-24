package com.emirates.emiratesIn.display.ui
{
	import com.emirates.emiratesIn.display.ui.debug.Debug;

	/**
	 * @author fraserhobbs
	 */
	public class QuestionScreen extends Screen
	{
		private var _questions:Vector.<Question> = new Vector.<Question>();
		
		public function QuestionScreen()
		{
			super();
		}
			
		override public function show() : void
		{
			super.show();
			
			for (var i : int = 0; i < _questions.length; i++)
			{
				_questions[i].reset();
			}
		}
		
		public function ask(question:String, answers:Array):void
		{
			var q:Question = new Question(question, answers);
			q.x = 20;
			addChild(q);
			_questions.push(q);
			
			update();
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
		}
	}
}
