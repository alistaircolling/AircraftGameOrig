package model.vo
{
	public class ReceivedDataVO
	{
		public var sparesCostInc:Number;		
		//passed from the black box at the start of each round
		
		public var currentReliability:InputObjectVO;
		public var currentSpares:Number;
		public var currentTuranaround:InputObjectVO;
		public var currentNFF:InputObjectVO;
		
		
		//params below are only used when passing data to update the view
	//	public var spares:Vector.<InputObjectVO>;
		public var reliability:Vector.<InputObjectVO>;
		public var turnaround:Vector.<InputObjectVO>;
		public var nff:Vector.<InputObjectVO>;
		//could remove lower values from 
		
		//tells us if this is the initial set of data or fmor black box (dictates which screen we go to )
		public var initialData:Boolean;
		
	}
}