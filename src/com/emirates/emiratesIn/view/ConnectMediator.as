package com.emirates.emiratesIn.view
{
	import com.emirates.emiratesIn.controller.signals.AttentionConnectedSignal;
	import com.emirates.emiratesIn.controller.signals.AttentionDisconnectedSignal;
	import com.emirates.emiratesIn.controller.signals.GotNextStateSignal;
	import com.emirates.emiratesIn.controller.signals.StateCompleteSignal;
	import com.emirates.emiratesIn.enum.State;
	import com.emirates.emiratesIn.view.components.ConnectView;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.Event;

	/**
	 * @author Fraser Hobbs
	 */
	public class ConnectMediator extends Mediator
	{
		[Inject]
		public var view:ConnectView;
		
		[Inject]
		public var nextStateSignal : GotNextStateSignal;
		
		[Inject]
		public var attentionConnectedSignal:AttentionConnectedSignal;
		
		[Inject]
		public var attentionDisconnectedSignal : AttentionDisconnectedSignal;
		
		[Inject]
		public var stateCompleteSignal : StateCompleteSignal;
		
		public function ConnectMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			nextStateSignal.add( stateHandler );
			
			attentionConnectedSignal.add( attentionConnectedHandler );
			attentionDisconnectedSignal.add( attentionDisconnectedHandler );
			
			view.addEventListener(Event.COMPLETE, viewCompleteHandler);
		}
		
		private function stateHandler(value:String):void
		{
			if (value == State.CONNECT)
			{
				view.show();
			}
		}
		
		private function attentionConnectedHandler():void
		{
			view.connected();
		}
		
		private function attentionDisconnectedHandler():void
		{
			view.disconnected();
		}
		
		private function viewCompleteHandler(event : Event) : void
		{
			view.hide();
			stateCompleteSignal.dispatch();
		}
	}
}
