package signals
{
	import model.vo.UserVO;
	
	import org.osflash.signals.Signal;
	
	public class UpdateWinner extends Signal
	{
		public function UpdateWinner()
		{
			super(UserVO, uint);
		}
	}
}