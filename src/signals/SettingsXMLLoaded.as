package signals
{
	import model.vo.SettingsVO;
	
	import org.osflash.signals.Signal;
	
	public class SettingsXMLLoaded extends Signal
	{
		public function SettingsXMLLoaded()
		{
			super(SettingsVO);
		}
	}
}