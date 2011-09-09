package com.emirates.emiratesIn.view
{
	import com.emirates.emiratesIn.controller.signals.ShowHideOutputSignal;
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import com.emirates.emiratesIn.enum.Config;
	import com.emirates.emiratesIn.service.DatabaseService;
	import com.emirates.emiratesIn.view.components.OutputView;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Fraser Hobbs
	 */
	public class OutputMediator extends Mediator
	{
		[Inject]
		public var view:OutputView;
		
		[Inject]
		public var showOutputSignal : ShowHideOutputSignal;
		
		[Inject]
		public var databaseService : DatabaseService;
		
		public function OutputMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			showOutputSignal.add(showOutputHandler);
		}
		
		private function showOutputHandler():void
		{
			Debug.log("showOutputHandler");
			
			if(view.visible)
			{
				view.hide();
			}
			else
			{
				view.show();
				
				var data:Array = databaseService.getTypeComparisionData();
				
				var typeComparisonData:Object = new Object();
				var type:String;
				var level:int;
				var completedTime:int;
				
				for (var i : int = 0; i < data.length; i++)
				{
					completedTime = data[i]["completedTime"];
					
					if(completedTime)
					{
						type = data[i]["type"];
						level = data[i]["level"];
						
						if(!typeComparisonData[type])
						{
							typeComparisonData[type] = new Array();
						}
						
						if(!typeComparisonData[type][level])
						{
							typeComparisonData[type][level] = new Object();
							typeComparisonData[type][level]["all"] = new Array();
						}
						
						if(completedTime < 0)
						{
							typeComparisonData[type][level]["all"].push(Config.TESTING_DURATION * 1000);
						}
						else
						{
							typeComparisonData[type][level]["all"].push(completedTime);
						}
					}
					
					Debug.log("completedTime " + data[i]["completedTime"]);
				}
				
				var total:int;
			
				for (var t : String in typeComparisonData)
				{
					for (var l : int = 0; l < typeComparisonData[t].length; l++)
					{
						total = 0;
						
						if(typeComparisonData[t][l])
						{
							for (var n : int = 0; n < typeComparisonData[t][l]["all"].length; n++)
							{
								total += typeComparisonData[t][l]["all"][n];
							}
							
							typeComparisonData[t][l]["average"] = total / typeComparisonData[t][l]["all"].length;
						}
						
					}
				}
				
				view.update(typeComparisonData);
				
			}
		}
	}
}
