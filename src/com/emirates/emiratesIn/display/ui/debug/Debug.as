package com.emirates.emiratesIn.display.ui.debug
{
	import com.bit101.components.TextArea;

	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * @author Fraser Hobbs
	 */
	public class Debug
	{
		// ----------------------------------------------------------------
		// CONSTANTS
		// ----------------------------------------------------------------
		
		
		// ----------------------------------------------------------------
		// PRIVATE MEMBERS
		// ----------------------------------------------------------------
		private static var _width:int = 200;
		private static var _height:int = 100;
		private static var _parent:DisplayObjectContainer;
		private static var _container:Sprite = new Sprite();
		private static var _canvas : Shape = new Shape();
		private static var _output : TextArea = new TextArea();
				
		// ----------------------------------------------------------------
		// CONSTRUCTOR
		// ----------------------------------------------------------------
		
		// ----------------------------------------------------------------
		// PUBLIC STATIC METHODS
		// ----------------------------------------------------------------
		public static function add(parent:DisplayObjectContainer):void
		{
			_container.visible = false;
			
			_parent = parent;
			_parent.addChild(_container);
			_container.x = 5;
			_container.y = 60;

			_container.addChild(_canvas);
			
			_container.addChild(_output);
			_output.x = 5;
			_output.y = 5;
			
			_parent.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDownHandler);
			
			draw();
		}
		
		public static function log(value:String):void
		{
			_output.text = value + "\n" + _output.text;
		}
		
		// ----------------------------------------------------------------
		// ACCESSORS
		// ----------------------------------------------------------------
		
		public static function set width(value : Number) : void
		{
			_width = value;
			
			draw();
		}
		
		public static function set height(value : Number) : void
		{
			_height = value;
			
			draw();
		}
		
		// ----------------------------------------------------------------
		// PRIVATE METHODS
		// ----------------------------------------------------------------
		
		private static function draw():void
		{
			_canvas.graphics.clear();
			_canvas.graphics.beginFill(0x000000, 0.5);
			_canvas.graphics.drawRect(0, 0, _width, _height);
			_canvas.graphics.endFill();
			
			_output.width = _width - 10;
			_output.height = _height - 10;
		}
		
		// ----------------------------------------------------------------
		// EVENT HANDLERS
		// ----------------------------------------------------------------
		
		private static function onKeyDownHandler(event : KeyboardEvent) : void
		{
			if (event.keyCode == Keyboard.D)
			{
				_container.visible = !_container.visible;
			}
		}
	}
}
