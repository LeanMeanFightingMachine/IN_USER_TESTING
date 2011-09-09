package com.emirates.emiratesIn.display.ui
{
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
		
		public function CompareTypesOutput()
		{
		}
		
		public function update(data:Object):void
		{
			var colour : Number;
			var sx : Number = WIDTH / Config.TESTING_LEVELS;
			var sy : Number = HEIGHT / (Config.TESTING_DURATION * 1000);
			var first:Boolean;
			
			graphics.clear();
			
			graphics.lineStyle(1,0x000000);
			graphics.moveTo(0, 0);
			graphics.lineTo(0, HEIGHT);
			graphics.lineTo(WIDTH, HEIGHT);
			
			for (var t : String in data)
			{
				colour = 0xFFFFFF * Math.random();
				graphics.lineStyle(1, colour);
				
				
				first = true;
				
				for (var l : int = 0; l < data[t].length; l++)
				{
					if(data[t][l])
					{
						Debug.log("+++ " + data[t][l]["average"]);
						
						Debug.log("+++ " + sy);
						
						if(first)
						{
							graphics.moveTo(l * sx, HEIGHT - (data[t][l]["average"] * sy));
							first = false;
						}
						else
						{
							graphics.lineTo(l * sx, HEIGHT - (data[t][l]["average"] * sy));
						}
						
						Debug.log("pos " + (HEIGHT - (data[t][l]["average"] * sy)));
					}
					
				}
			}
		}
	}
}
