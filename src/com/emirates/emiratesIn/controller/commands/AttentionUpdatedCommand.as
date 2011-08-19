package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.net.Attention;
	import com.emirates.emiratesIn.model.AttentionModel;
	import com.emirates.emiratesIn.net.events.AttentionEvent;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author fraserhobbs
	 */
	public class AttentionUpdatedCommand extends Command
	{
		[Inject]
		public var event:AttentionEvent;
		
		[Inject]
		public var attentionModel:AttentionModel;
		
		override public function execute():void
		{
			attentionModel.add(event.value);
		}
	}
}
