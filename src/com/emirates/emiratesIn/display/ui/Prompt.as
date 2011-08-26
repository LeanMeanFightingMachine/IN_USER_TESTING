package com.emirates.emiratesIn.display.ui
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * @author Fraser Hobbs
	 */
	public class Prompt extends Clip
	{
		private var _text:TextField;
		private var _format:TextFormat;
		
		public function Prompt(text:String)
		{
			super();
			
			_format = new TextFormat(new FuturaCondensedExtraBold().fontName,14,0x000000,true);
			
			_text = new TextField();
			_text.x = -148;
			_text.width = 150;
			_text.embedFonts = true;
			_text.autoSize = TextFieldAutoSize.LEFT;
			_text.multiline = true;
			_text.wordWrap = true;
			_text.selectable = false;
			_text.defaultTextFormat = _format;
			_text.text = text;	
			addChild(_text);
		}
			
		override protected function draw() : void
		{
			super.draw();
			
			_text.y = -_text.height - 15;
			
			graphics.clear();
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(-153, -_text.height - 20, 160, _text.height + 10);
			graphics.moveTo(-7, -10);
			graphics.lineTo(0, 0);
			graphics.lineTo(7, -10);
			graphics.lineTo(-7, -10);
			graphics.endFill();
		}
	}
}
