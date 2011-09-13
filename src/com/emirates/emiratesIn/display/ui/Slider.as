package com.emirates.emiratesIn.display.ui
{
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * @author Fraser Hobbs
	 */
	public class Slider extends Sprite
	{
		private var _format:TextFormat;
		private var _min:TextField;
		private var _max:TextField;
		private var _control:Sprite = new Sprite();
				
		public function Slider(min:String, max:String)
		{
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0, 25, 500, 20);
			graphics.endFill();
			
			_format = new TextFormat(new FuturaCondensedExtraBold().fontName,14,0xFFFFFF,true);
			
			_min = new TextField();
			_min.width = 0;
			_min.embedFonts = true;
			_min.autoSize = TextFieldAutoSize.LEFT;
			_min.multiline = false;
			_min.wordWrap = false;
			_min.selectable = false;
			_min.defaultTextFormat = _format;
			_min.text = min;
			addChild(_min);
			
			_max = new TextField();
			_max.width = 0;
			_max.embedFonts = true;
			_max.autoSize = TextFieldAutoSize.LEFT;
			_max.multiline = false;
			_max.wordWrap = false;
			_max.selectable = false;
			_max.defaultTextFormat = _format;
			_max.text = max;
			_max.x = 500 - _max.width;	
			addChild(_max);
			
			_control.graphics.beginFill(0x000000);
			_control.graphics.drawRect(0, 0, 16, 16);
			_control.graphics.endFill();
			addChild(_control);
			_control.x = 2;
			_control.y = 27;
			
			_control.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_control.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		private function mouseUpHandler(event : MouseEvent) : void
		{
			_control.startDrag(false,new Rectangle(2,27,480,0));
		}

		private function mouseDownHandler(event : MouseEvent) : void
		{
			
		}
	}
}
