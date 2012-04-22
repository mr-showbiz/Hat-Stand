package hatstand.models
{
	import mx.collections.ArrayCollection;
	import mx.logging.Log;

	public class Player
	{
		private var _activePieces:ArrayCollection;
		[Bindable]public var name:String; 
		
		public function Player(direction:int)
		{
			//Temporary naming
			var playerColour:String = direction == DraughtsPiece.DIRECTION_UP ? "Black" : "White";
			name = "Player (" + playerColour + ")"; 
			
			if(direction == DraughtsPiece.DIRECTION_UP) _activePieces = generatePieces(direction, 5);
			if(direction == DraughtsPiece.DIRECTION_DOWN) _activePieces = generatePieces(direction, 0);
			if(!_activePieces) throw new Error("Error in creating playing pieces");
		}
		
		public function get activePieces() : ArrayCollection { return _activePieces; }
		
		private function generatePieces(direction:int, startYcoord:int) : ArrayCollection
		{
			var pieces:ArrayCollection = new ArrayCollection();
			
			//Currently hardcoded for 8x8 board
			for(var x:int = 0; x < 8; x++)
			{
				var y:int = startYcoord;
				while(y < startYcoord+3)
				{
					if((x%2 == 0 && y%2 == 0) || (x%2 > 0 && y%2 > 0)) pieces.addItem( new DraughtsPiece(direction, [x, y], this));
					y++;
				}
			}
			return pieces;
		}
	}
}