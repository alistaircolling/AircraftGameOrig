package model.vo
{
	public class InputDataVO
	{
		//passed from the black box at the start of each round
		
		public var budget:Number;
		public var iteration:int;
		
		public var currentReliability:InputObjectVO;
		public var currentSpares:Number;
		public var currentTuranaround:InputObjectVO;
		public var currentNFF:InputObjectVO;
		
		public var sparesMin:Number;
		public var sparesInc:Number;
		
		//params below are only used when passing data to update the view
	//	public var spares:Vector.<InputObjectVO>;
		public var reliability:Vector.<InputObjectVO>;
		public var turnaround:Vector.<InputObjectVO>;
		public var nff:Vector.<InputObjectVO>;
		
	}
}