package signals
{
	import model.vo.SettingsVO;
	
	import org.osflash.signals.Signal;
	
	public class SettingsUpdated extends Signal
	{
		public function SettingsUpdated():void{
			super(SettingsVO);	
		}
		
	}
}