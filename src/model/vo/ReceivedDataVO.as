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
		
		public var iteration:uint;//only used to check the last iteratoin by finalviewmediator
		public var avAvailability:Number;//only used in final stage (3)
		public var finalScore:Number;//only used on final stage ----check how it is set--using budget for now
		public var costPerFHr:Number;
		
		//params below are only used when passing data to update the view
	//	public var spares:Vector.<InputObjectVO>;
		public var reliability:Vector.<InputObjectVO>;
		public var turnaround:Vector.<InputObjectVO>;
		public var nff:Vector.<InputObjectVO>;
		//could remove lower values from 
		
		//tells us if this is the initial set of data or fmor black box (dictates which screen we go to )
		public var initialData:Boolean;
		//used to display on the input screen
		public var lastPercent:Number;
		//used to display the debug window
		public var debug:Boolean;
		
	}
}