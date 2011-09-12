package com.emirates.emiratesIn.display.ui
{
	import flash.display.Shape;
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import com.emirates.emiratesIn.enum.Config;

	import flash.display.Sprite;

	/**
	 * @author Fraser Hobbs
	 */
	public class CompareTypesOutput extends Sprite
	{
		public static const WIDTH:int = 300;
		public static const HEIGHT:int = 250;
		
		public static const INCREMENT_Y:Number = 1000;
		
		private var _tx:String;
		private var _ix:Number;
		
		private var _mx :Number;
		private var _my :Number;
		
		private var _graph:Shape = new Shape();
		private var _axis:OutputAxis;
		private var _key:OutputKey;
		
		public function CompareTypesOutput(tx:String,ix:Number, mx:int)
		{
			_tx = tx;
			_ix = ix;
			_mx = mx;
			
			addChild(_graph);
			
			_my = Config.TESTING_DURATION * 1000;

			_axis = new OutputAxis(WIDTH, HEIGHT, _ix, INCREMENT_Y, _mx, _my, tx, "avg. time");
			addChild(_axis);
			
			_key = new OutputKey();
			addChild(_key);
			_key.x = WIDTH + 20;
		}
		
		public function update(data:Object):void
		{
			var colour : Number;
			var sx : Number = WIDTH / _mx;
			var sy : Number = HEIGHT / _my;
			var first:Boolean;
			
			_graph.graphics.clear();
			_key.clear();
			
			for (var t : String in data)
			{
				colour = 0xFFFFFF * Math.random();
				
				_key.add(colour, t);
				
				_graph.graphics.lineStyle(1, colour);
				
				first = true;
				
				for (var l : int = 0; l < data[t][_tx].length; l++)
				{
					if(data[t][_tx][l])
					{
						if(first)
						{
							_graph.graphics.moveTo(l * sx, HEIGHT - (data[t][_tx][l]["average"] * sy));
							first = false;
						}
						else
						{
							_graph.graphics.lineTo(l * sx, HEIGHT - (data[t][_tx][l]["average"] * sy));
						}
					}
				}
			}
			
			
		}
	}
}
