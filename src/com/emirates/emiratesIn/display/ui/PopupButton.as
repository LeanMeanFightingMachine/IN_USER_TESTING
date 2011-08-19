package com.emirates.emiratesIn.display.ui
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * @author fraserhobbs
	 */
	public class PopupButton extends Sprite
	{
		protected var _text:TextField;
		protected var _format:TextFormat;
		
		public function PopupButton()
		{
			_format = new TextFormat(new FuturaCondensedExtraBold().fontName,20,0x000000,true);
			
			_text = new TextField();
			_text.x = 5;
			_text.y = 2;
			_text.width = 5;
			_text.embedFonts = true;
			_text.autoSize = TextFieldAutoSize.LEFT;
			_text.multiline = false;
			_text.wordWrap = false;
			_text.selectable = false;
			_text.defaultTextFormat = _format;		
			addChild(_text);
			
			mouseChildren = false;
			buttonMode = true;
		}
		
		public function set text(value:String):void
		{
			_text.text = value;
			
			draw();
		}
		
		private function draw():void
		{
			graphics.clear();
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0, 0, _text.width + 10, _text.height + 4);
			graphics.endFill();
		}
	}
}
