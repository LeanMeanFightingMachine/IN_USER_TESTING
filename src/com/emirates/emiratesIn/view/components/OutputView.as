package com.emirates.emiratesIn.view.components
{
	import com.emirates.emiratesIn.display.ui.CompareTypesOutput;
	import com.emirates.emiratesIn.display.ui.OutputBackground;
	import com.emirates.emiratesIn.enum.Config;

	/**
	 * @author Fraser Hobbs
	 */
	public class OutputView extends View
	{
		private var _background:OutputBackground = new OutputBackground();
		
		private var _compareTypesByLevelOutput : CompareTypesOutput = new CompareTypesOutput("level", 1, Config.TESTING_LEVELS - 1);
		private var _compareTypesByHoldOutput : CompareTypesOutput = new CompareTypesOutput("hold", 1, Config.TESTING_HOLD.length - 1);
		
		public function OutputView()
		{
			super();
			
			addChild(_background);
			_background.show();
			
			addChild(_compareTypesByLevelOutput);
			_compareTypesByLevelOutput.x = 100;
			_compareTypesByLevelOutput.y = 100;
			
			addChild(_compareTypesByHoldOutput);
			_compareTypesByHoldOutput.x = 500;
			_compareTypesByHoldOutput.y = 100;
		}
		
		public function update(data:Object):void
		{
			_compareTypesByLevelOutput.update(data);
			_compareTypesByHoldOutput.update(data);
		}
	}
}
