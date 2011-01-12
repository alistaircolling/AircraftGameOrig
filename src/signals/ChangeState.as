package signals
{
	import org.osflash.signals.Signal;
	
	public class ChangeState extends Signal
	{
		public static const INTRO_SCREEN:String = "intro";
		public static const ENTER_SCREEN:String = "enter";
		public static const RESULTS_SCREEN:String = "results"
		public static const FINAL_SCREEN:String = "final";
		
		public function ChangeState():void{
			
			super(String);
			
		}
	}
}