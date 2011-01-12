package controllers
{
	
	
	
	import org.robotlegs.mvcs.SignalCommand;
	
	import services.CompiledXMLService;
	
	public class LoadSettingsXMLCommand extends SignalCommand
	{
		[Inject]
		public var service:CompiledXMLService;
		
		private static const _XML_URL:String = "xml/settings.xml";
		
		override public function execute():void{
			trace("asd");
			service.loadXML();
			
		}
	}
}