package com.emirates.emiratesIn.display.ui
{
	import com.emirates.emiratesIn.display.ui.events.PopupEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * @author fraserhobbs
	 */
	public class Popup extends Clip
	{
		protected var _headingText:TextField;
		protected var _headingFormat:TextFormat;
		protected var _bodyText:TextField;
		protected var _bodyFormat:TextFormat;
		protected var _button:PopupButton;
		
		public function Popup()
		{
			super();
			
			_headingFormat = new TextFormat(new FuturaCondensedExtraBold().fontName,40,0xFFFFFF,true);
			
			_headingText = new TextField();
			_headingText.x = 20;
			_headingText.y = 20;
			_headingText.width = 460;
			_headingText.embedFonts = true;
			_headingText.autoSize = TextFieldAutoSize.LEFT;
			_headingText.multiline = true;
			_headingText.wordWrap = true;
			_headingText.selectable = false;
			_headingText.defaultTextFormat = _headingFormat;
			addChild(_headingText);
			
			_bodyFormat = new TextFormat(new FuturaMedium().fontName,20,0xFFFFFF);
			
			_bodyText = new TextField();
			_bodyText.x = 20;
			_bodyText.width = 460;
			_bodyText.embedFonts = true;
			_bodyText.autoSize = TextFieldAutoSize.LEFT;
			_bodyText.multiline = true;
			_bodyText.wordWrap = true;
			_bodyText.selectable = false;
			_bodyText.defaultTextFormat = _bodyFormat;		
			addChild(_bodyText);

			_button = new PopupButton();
			addChild(_button);
			_button.addEventListener(MouseEvent.CLICK, buttonClickHandler);
		}
		
		public function set heading(value:String):void
		{
			_headingText.text = value;
			
			update();
		}
		
		public function set body(value:String):void
		{
			_bodyText.text = value;
			
			update();
		}
		
		public function set button(value:String):void
		{
			_button.text = value;
			
			update();
		}
		
		override protected function resize():void
		{
			update();
		}
		
		override protected function draw():void
		{
			_bodyText.y = _headingText.y + _headingText.height + 20;
			
			_button.x = 500 - _button.width - 20;
			_button.y = _bodyText.y + _bodyText.height + 20;
			
			graphics.clear();
			graphics.beginFill(0x00);
			graphics.drawRect(0, 0, 500, _button.y + _button.height + 20);
			graphics.endFill();
			
			x = int((stage.stageWidth - width) * 0.5);
			y = int((stage.stageHeight - height) * 0.5);
		}
		
		private function buttonClickHandler(event : MouseEvent) : void
		{
			dispatchEvent(new PopupEvent(PopupEvent.COMPLETE));
		}
	}
}
