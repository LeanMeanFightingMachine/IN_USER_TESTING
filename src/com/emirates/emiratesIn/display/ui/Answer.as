package com.emirates.emiratesIn.display.ui
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * @author fraserhobbs
	 */
	public class Answer extends Clip
	{
		private var _id:int;
		protected var _text:TextField;
		protected var _format:TextFormat;
		
		public function Answer(id:int, text:String)
		{
			super();
			
			_id = id;
			
			_format = new TextFormat(new FuturaCondensedExtraBold().fontName,20,0xFFFFFF,true);
			
			_text = new TextField();
			_text.x = 25;
			_text.width = 0;
			_text.embedFonts = true;
			_text.autoSize = TextFieldAutoSize.LEFT;
			_text.multiline = false;
			_text.wordWrap = false;
			_text.selectable = false;
			_text.defaultTextFormat = _format;
			_text.text = text;	
			addChild(_text);
			
			graphics.lineStyle(2,0xFFFFFF);
			graphics.beginFill(0xFFFFFF, 0.5);
			graphics.drawCircle(10, 15, 8);
			graphics.endFill();
			
			mouseChildren = false;
			buttonMode = true;
			
			show();
		}
		
		public function select():void
		{
			graphics.clear();
			graphics.lineStyle(2,0xFFFFFF);
			graphics.beginFill(0xFFFFFF, 1);
			graphics.drawCircle(10, 15, 8);
			graphics.endFill();
		}
		
		public function unselect():void
		{
			graphics.clear();
			graphics.lineStyle(2,0xFFFFFF);
			graphics.beginFill(0xFFFFFF, 0.5);
			graphics.drawCircle(10, 15, 8);
			graphics.endFill();
		}
		
		public function get id():int
		{
			return _id;
		}
	}
}
