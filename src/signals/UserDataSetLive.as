package signals
{
	//this class was created as userdata set was not being heard in input mediator when using dummy tests
	import model.vo.ReceivedDataVO;
	
	import org.osflash.signals.Signal;
	
	public class UserDataSetLive extends Signal
	{
		public function UserDataSetLive()
		{
			super(ReceivedDataVO);
		}
	}
}