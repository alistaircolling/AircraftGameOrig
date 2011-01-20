package signals
{
	import org.osflash.signals.Signal;
	
	public class ChangeState extends Signal
	{
		public static const INTRO_SCREEN:String = "intro";
		public static const ENTER_SCREEN:String = "enter";
		public static const RESULTS_SCREEN:String = "resultsScreen"
		public static const FINAL_SCREEN:String = "finalScreen";
		public static const EXIT_SCREEN:String = "exitScreen";
		
		public function ChangeState():void{
			
			super(String);
			
		}
	}
}