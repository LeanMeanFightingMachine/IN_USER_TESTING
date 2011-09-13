package com.emirates.emiratesIn.display.ui
{
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
		private var _slider:Slider;
		private var _answer:int = -1;
		private var _id:int;
		
		public function Question(id:int,question:String,min:String,max:String)
		{
			super();
			
			_id = id;
			
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
			
			_slider = new Slider(min, max);
			addChild(_slider);
			_slider.y = _questionText.y + _questionText.height + 10;
			
			show();
		}
		
		public function reset():void
		{
			
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function get answer():int
		{
			return _answer;
		}

		
	}
}
