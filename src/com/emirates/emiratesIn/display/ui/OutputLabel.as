package com.emirates.emiratesIn.display.ui
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * @author Fraser Hobbs
	 */
	public class OutputLabel extends Sprite
	{
		private var _format:TextFormat;
		private var _text:TextField;
		
		public function OutputLabel(text:String)
		{
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
			
			_text.x = -int(_text.width * 0.5);
		}
	}
}
