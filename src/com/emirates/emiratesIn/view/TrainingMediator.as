package com.emirates.emiratesIn.view
{
	import com.emirates.emiratesIn.controller.signals.AttentionUpdatedSignal;
	import com.emirates.emiratesIn.controller.signals.StartTrainingSignal;
	import com.emirates.emiratesIn.view.components.TrainingView;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author fraserhobbs
	 */
	public class TrainingMediator extends Mediator
	{
		[Inject]
		public var view:TrainingView;
		
		[Inject]
		public var startTrainingSignal:StartTrainingSignal;
		
		[Inject]
		public var attentionUpdatedSignal:AttentionUpdatedSignal;
		
		public function TrainingMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			startTrainingSignal.add( startTrainingSignalHandler );
			attentionUpdatedSignal.add( attentionUpdatedSignalHandler );
		}
		
		private function startTrainingSignalHandler():void
		{
			view.show();
		}
		
		private function attentionUpdatedSignalHandler(value:int):void
		{
			view.attention(value);
		}
	}
}
