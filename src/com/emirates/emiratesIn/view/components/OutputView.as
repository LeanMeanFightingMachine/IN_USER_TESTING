package com.emirates.emiratesIn.view.components
{
	import com.emirates.emiratesIn.display.ui.CompareTypesOutput;
	import com.emirates.emiratesIn.display.ui.OutputBackground;

	/**
	 * @author Fraser Hobbs
	 */
	public class OutputView extends View
	{
		private var _background:OutputBackground = new OutputBackground();
		
		private var _compareTypesOutput:CompareTypesOutput = new CompareTypesOutput();
		
		public function OutputView()
		{
			super();
			
			addChild(_background);
			_background.show();
			
			addChild(_compareTypesOutput);
			_compareTypesOutput.x = 100;
			_compareTypesOutput.y = 100;
		}
		
		public function update(data:Object):void
		{
			_compareTypesOutput.update(data);
		}
	}
}
