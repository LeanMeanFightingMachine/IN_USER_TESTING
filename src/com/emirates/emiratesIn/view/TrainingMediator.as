package com.emirates.emiratesIn.view
{
	import com.emirates.emiratesIn.controller.signals.AttentionUpdatedSignal;
	import com.emirates.emiratesIn.controller.signals.TrainingStartSignal;
	import com.emirates.emiratesIn.controller.signals.TrainingCompleteSignal;
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
		public var trainingStartSignal:TrainingStartSignal;
		
		[Inject]
		public var trainingCompleteSignal : TrainingCompleteSignal;
		
		[Inject]
		public var attentionUpdatedSignal:AttentionUpdatedSignal;
		
		public function TrainingMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			trainingStartSignal.add( startHandler );
			attentionUpdatedSignal.add( attentionUpdatedSignalHandler );
			
			view.addEventListener(Event.COMPLETE, viewCompleteHandler);
		}

		private function startHandler():void
		{
			view.show();
		}
		
		private function attentionUpdatedSignalHandler(value:int):void
		{
			view.attention(value);
		}
		
		private function viewCompleteHandler(event : Event) : void
		{
			view.hide();
			trainingCompleteSignal.dispatch();
		}
	}
}