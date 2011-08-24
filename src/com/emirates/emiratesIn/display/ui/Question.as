package com.emirates.emiratesIn.display.ui
{
	import flash.data.EncryptedLocalStore;
	import com.emirates.emiratesIn.display.ui.debug.Debug;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * @author fraserhobbs
	 */
	public class Question extends Clip
	{
		protected var _questionText:TextField;
		protected var _questionFormat:TextFormat;
		protected var _answers:Vector.<Answer> = new Vector.<Answer>();
		private var _answerContainer:Sprite = new Sprite();
		private var _answer:int = -1;
		
		public function Question(question:String,answers:Array)
		{
			super();
			
			Debug.log(question);
			
			_questionFormat = new TextFormat(new FuturaCondensedExtraBold().fontName,20,0xFFFFFF,true);
			
			_questionText = new TextField();
			_questionText.width = 700;
			_questionText.embedFonts = true;
			_questionText.autoSize = TextFieldAutoSize.LEFT;
			_questionText.multiline = true;
			_questionText.wordWrap = true;
			_questionText.selectable = false;
			_questionText.defaultTextFormat = _questionFormat;
			_questionText.text = question;	
			addChild(_questionText);
			
			addChild(_answerContainer);
			_answerContainer.y = _questionText.y + _questionText.height + 10;
			
			var pos:int;
			var an:Answer;
			for (var i : int = 0; i < answers.length; i++)
			{
				an = new Answer(i, answers[i]);
				an.x = pos;
				an.addEventListener(MouseEvent.CLICK, answerClickHandler);
				pos = an.x + an.width + 30;
				_answerContainer.addChild(an);
				_answers.push(an);
			}
			
			show();
		}
		
		public function reset():void
		{
			_answer = -1;
			
			for (var i : int = 0; i < _answers.length; i++)
			{
				_answers[i].unselect();
			}
		}
		
		public function get answer():int
		{
			return _answer;
		}

		private function answerClickHandler(event : MouseEvent) : void
		{
			var an : Answer = event.target as Answer;
			
			_answer = an.id;
			
			for (var i : int = 0; i < _answers.length; i++)
			{
				if(i == an.id)
				{
					_answers[i].select();
				}
				else
				{
					_answers[i].unselect();
				}
			}
		}
	}
}
