package hatstand.models
{
	import mx.collections.ArrayCollection;

	/**
	 * DOES THIS REALLY NEED TO BE A SINGLTON??!
	 **/
	
	public class Rules
	{
		private static var _instance:Rules;
		
		private var selectedPlayingPiece:DraughtsPiece;
		public var game:Game;
		
		public static function getInstance() : Rules
		{
			return _instance ? _instance : _instance = new Rules();
		}
		
		public function validateMoves(draughtPiece:DraughtsPiece) : ArrayCollection
		{
			selectedPlayingPiece = draughtPiece;
			
			return rule1();
		}
		
		//Only go diagnal 1 space
		private function rule1() : ArrayCollection
		{
			var validCoords:ArrayCollection = new ArrayCollection();
			
			var newY:int;
			if(selectedPlayingPiece.direction == DraughtsPiece.DIRECTION_UP)
			{
				newY = selectedPlayingPiece.y + 1;
			}
			else
			{
				newY = selectedPlayingPiece.y - 1;
			}
			
			var newX:int = selectedPlayingPiece.x - 1;
			validCoords.addItem([newX, newY]);
			
			var newX2:int = selectedPlayingPiece.x + 1;
			validCoords.addItem([newX2, newY]);
			
			return rule2(validCoords); 
		}
		
		//Are any of the spaces already taken
		private function rule2(coordinateList:ArrayCollection) : ArrayCollection
		{
			var inValidCoords:ArrayCollection = new ArrayCollection();
			for each(var coordinate:Array in coordinateList)
			{
				for each(var draughtsPiece:DraughtsPiece in game.player1.activePieces)
				{
					if(coordinate[0] == draughtsPiece.x && coordinate[1] == draughtsPiece.y) 
					{
						inValidCoords.addItem(coordinate);
						break;
					}
				}
				for each(var draughtsPiece:DraughtsPiece in game.player2.activePieces)
				{
					if(coordinate[0] == draughtsPiece.x && coordinate[1] == draughtsPiece.y) 
					{
						inValidCoords.addItem(coordinate);
						break;
					}
				}
			}
			
			for each(var inValidCoordinate:Array in inValidCoords)
			{
				coordinateList.removeItemAt(coordinateList.getItemIndex(inValidCoordinate));
			}
			
			return coordinateList;
		}
	}
}
