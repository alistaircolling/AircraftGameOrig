package model.vo
{
	public class InputDataVO
	{
		//passed from the black box at the start of each round
		
		public var budget:Number;
		public var iteration:int;
		
		public var currentReliability:Number;
		public var currentSpares:Number;
		public var currentTuranaround:Number;
		public var currentNFF:Number;
		
		public var sparesMin:Number;
		public var sparesInc:Number;
		
		//params below are only used when passing data to update the view
	//	public var spares:Vector.<InputObjectVO>;
		public var reliability:Vector.<InputObjectVO>;
		public var turnaround:Vector.<InputObjectVO>;
		public var nff:Vector.<InputObjectVO>;
		
	}
}