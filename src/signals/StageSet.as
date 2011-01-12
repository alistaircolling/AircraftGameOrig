package signals
{
	import org.osflash.signals.Signal;
	
	public class StageSet extends Signal
	{
		/* -1 intro, 
		0 entering first round, 1 showing first round, 
		2 entering 2nd round, 3, showing 2nd round,
		4, entering 3rd round, 5, showing 3rd round,
		6 Final score screen
		7 Exit Slide Screen */
		
		
		public function StageSet()
		{
			super(int);
		}
	}
}