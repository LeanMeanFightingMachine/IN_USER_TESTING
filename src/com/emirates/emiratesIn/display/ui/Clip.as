package com.emirates.emiratesIn.display.ui
{
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author fraserhobbs
	 */
	public class Clip extends Sprite
	{
		private var _dirty:Boolean = false;
		private var _showing:Boolean = true;
		
		public function Clip()
		{
			visible = false;
			_showing = false;
		}
		
		public function show():void
		{
			_showing = true;
			
			if(stage)
			{
				stage.addEventListener(Event.RESIZE, resizeHandler);
				resize();
				update();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			}
		}

		public function hide():void
		{
			visible = false;
			_showing = false;
			
			if(stage.hasEventListener(Event.RESIZE))
			{
				stage.removeEventListener(Event.RESIZE, resizeHandler);
			}
			
			if(hasEventListener(Event.ADDED_TO_STAGE))
			{
				removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			}
		}
		
		protected function resize():void
		{
			
		}
		
		protected function draw():void
		{
			
		}
		
		protected function update():void
		{
			if(stage && !_dirty)
			{
				_dirty = true;
				addEventListener(Event.ENTER_FRAME, updateHandler);
			}
		}

		private function updateHandler(event : Event) : void
		{
			_dirty = false;
			removeEventListener(Event.ENTER_FRAME, updateHandler);
			
			if(!visible && _showing) visible = true;
			
			draw();
		}
		
		private function resizeHandler(event : Event) : void
		{
			resize();
		}
		
		private function addedToStageHandler(event : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			stage.addEventListener(Event.RESIZE, resizeHandler);
			
			resize();
			update();
		}
	}
}
