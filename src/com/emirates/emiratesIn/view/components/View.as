package com.emirates.emiratesIn.view.components
{
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author fraserhobbs
	 */
	public class View extends Sprite
	{
		public function View()
		{
			visible = false;
		}
		
		public function show():void
		{
			visible = true;
			
			resize();
			
			stage.addEventListener(Event.RESIZE, resizeHandler);
		}

		public function hide():void
		{
			visible = false;
			
			stage.removeEventListener(Event.RESIZE, resizeHandler);
		}
		
		protected function resize():void
		{
			
		}
		
		private function resizeHandler(event : Event) : void
		{
			resize();
		}
	}
}
