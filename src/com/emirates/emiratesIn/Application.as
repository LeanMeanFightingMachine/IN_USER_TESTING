package 
com.emirates.emiratesIn
{
	import com.bit101.components.Style;
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import com.emirates.emiratesIn.display.ui.debug.Graph;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	/**
	 * @author Fraser Hobbs
	 */
	public class Application extends Sprite
	{
		// ----------------------------------------------------------------
		// PRIVATE MEMBERS
		// ----------------------------------------------------------------
		
		private var context : ApplicationContext;
		
		// ----------------------------------------------------------------
		// CONSTRUCTOR
		// ----------------------------------------------------------------
		public function Application()
		{
			context = new ApplicationContext(this);

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			Graph.add(this);
			Debug.add(this);
			
			Style.setStyle(Style.DARK);
		}
	}
}