package com.emirates.emiratesIn.display.ui
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * @author Fraser Hobbs
	 */
	public class OutputKeyItem extends Sprite
	{
		private var _format:TextFormat;
		private var _text:TextField;
		
		public function OutputKeyItem(colour:Number, text:String, y:int)
		{
			this.y = y;
			
			graphics.beginFill(colour);
			graphics.drawRect(0, 3, 10, 10);
			graphics.endFill();
			
			_format = new TextFormat(new FuturaCondensedExtraBold().fontName,10,0x000000,true);
			
			_text = new TextField();
			_text.width = 0;
			_text.embedFonts = true;
			_text.autoSize = TextFieldAutoSize.LEFT;
			_text.multiline = false;
			_text.wordWrap = false;
			_text.selectable = false;
			_text.defaultTextFormat = _format;
			_text.text = text;	
			addChild(_text);
			_text.x = 12;
		}
	}
}
