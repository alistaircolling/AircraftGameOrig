package signals
{
	import model.vo.ReceivedDataVO;
	
	import org.osflash.signals.Signal;
	
	
	//triggered when the black box receives parameters (either initial or after user submission)
	public class UserDataSet extends Signal
	{
		public function UserDataSet(){
			super(ReceivedDataVO);
		}
	
		
	}
}