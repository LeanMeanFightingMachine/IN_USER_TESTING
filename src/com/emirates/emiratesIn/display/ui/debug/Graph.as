package com.emirates.emiratesIn.display.ui.debug
{
	import com.emirates.emiratesIn.net.Attention;
	import com.emirates.emiratesIn.net.events.AttentionEvent;

	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	/**
	 * @author Fraser Hobbs
	 */
	public class Graph
	{
		// ----------------------------------------------------------------
		// CONSTANTS
		// ----------------------------------------------------------------
		private static const MAX:int = 100;
		
		// ----------------------------------------------------------------
		// PRIVATE MEMBERS
		// ----------------------------------------------------------------
		private static var _attention:Array = [];
		private static var _average:Array = [];
		private static var _width:int = 200;
		private static var _height:int = 50;
		private static var _parent:DisplayObjectContainer;
		private static var _canvas : Shape = new Shape();
				
		// ----------------------------------------------------------------
		// CONSTRUCTOR
		// ----------------------------------------------------------------
		
		// ----------------------------------------------------------------
		// PUBLIC STATIC METHODS
		// ----------------------------------------------------------------
		public static function add(parent:DisplayObjectContainer):void
		{
			_canvas.visible = false;
			
			_parent = parent;
			_parent.addChild(_canvas);
			_canvas.x = 5;
			_canvas.y = 5;
			
			draw();
			
			_parent.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDownHandler);
			
			Attention.addEventListener(AttentionEvent.UPDATED, attentionUpdatedHandler);
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
			
			var inc:int = Math.ceil(_width / MAX);
			var start:int = _width - ((_attention.length - 1) * inc);
			var i : int ;
			
			_canvas.graphics.lineStyle(1,0xFF0000);
			_canvas.graphics.moveTo(start, _height - int((_attention[0] / 100) * _height));
			for (i = 1; i < _attention.length; i++)
			{
				_canvas.graphics.lineTo(start + (i * inc), _height - int((_attention[i] / 100) * _height));
			}
			
			_canvas.graphics.lineStyle(1,0x0000FF);
			_canvas.graphics.moveTo(start, _height - int((_average[0] / 100) * _height));
			for (i = 1; i < _average.length; i++)
			{
				_canvas.graphics.lineTo(start + (i * inc), _height - int((_average[i] / 100) * _height));
			}
		}
		
		// ----------------------------------------------------------------
		// EVENT HANDLERS
		// ----------------------------------------------------------------
		private static function attentionUpdatedHandler(event : AttentionEvent) : void
		{
			if (!_width || !_height) return;
			
			_attention.push(Attention.current);
			
			_average.push(Attention.average);

			if (_attention.length > MAX)
			{
				_attention.shift();
			}
			
			if (_average.length > MAX)
			{
				_average.shift();
			}
			
			draw();
		}
		
		private static function onKeyDownHandler(event : KeyboardEvent) : void
		{
			if (event.keyCode == Keyboard.G)
			{
				_canvas.visible = !_canvas.visible;
			}
		}
	}
}
