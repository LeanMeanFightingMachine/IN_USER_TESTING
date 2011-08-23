package com.emirates.emiratesIn.view
{
	import com.emirates.emiratesIn.controller.signals.AttentionUpdateSignal;
	import com.emirates.emiratesIn.controller.signals.GotNextStateSignal;
	import com.emirates.emiratesIn.controller.signals.StateCompleteSignal;
	import com.emirates.emiratesIn.enum.State;
	import com.emirates.emiratesIn.view.components.TrainingView;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.Event;

	/**
	 * @author fraserhobbs
	 */
	public class TrainingMediator extends Mediator
	{
		[Inject]
		public var view:TrainingView;
		
		[Inject]
		public var nextStateSignal : GotNextStateSignal;
		
		[Inject]
		public var stateCompleteSignal : StateCompleteSignal;
		
		[Inject]
		public var attentionUpdatedSignal:AttentionUpdateSignal;
		
		public function TrainingMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			nextStateSignal.add( stateHandler );
			attentionUpdatedSignal.add( attentionUpdatedHandler );
			
			view.addEventListener(Event.COMPLETE, viewCompleteHandler);
		}

		private function stateHandler(value:String):void
		{
			if (value == State.TRAINING)
			{
				view.show();
			}
		}
		
		private function attentionUpdatedHandler(value:int):void
		{
			view.attention(value);
		}
		
		private function viewCompleteHandler(event : Event) : void
		{
			view.hide();
			stateCompleteSignal.dispatch();
		}
	}
}