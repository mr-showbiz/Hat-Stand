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
				newY = selectedPlayingPiece.y - 1;
			}
			else
			{
				newY = selectedPlayingPiece.y + 1;
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
			var playingPieces:ArrayCollection = allActivePieces;
			for each(var coordinate:Array in coordinateList)
			{
				if(isCoordinateOccupied(coordinate, playingPieces)) inValidCoords.addItem(coordinate);
			}
			
			for each(var inValidCoordinate:Array in inValidCoords)
			{
				coordinateList.removeItemAt(coordinateList.getItemIndex(inValidCoordinate));
			}
			
			return new ArrayCollection(coordinateList.source.concat(rules3(inValidCoords).source));
		}
		
		/* Checks the space diagonal over from the invalid coord to see if it's free.
		   If it is, then we can potentially jump over the invalid coord's playing piece
		   TODO: only make it pay attention to other players pieces
		*/
		private function rules3(invalidCoords:ArrayCollection) : ArrayCollection
		{
			var availableJumpedCoords:ArrayCollection = new ArrayCollection();

			//Iterate through all invalid coords
			for each(var coord:Array in invalidCoords)
			{
				/* If the invalid coordinates x value minus our selected pieces x value is greater than 0 then we must
				   Plus 1 to the invalid coordinates x value to carry the diagonal through to the otherside.
				*/
				var xVariant:int = coord[0] - selectedPlayingPiece.x > 0 ? 1 : -1;
				/*TODO: Make it pay attention to KINDED pieces!!!
				  If our selected piece is heading up the board, we need to minus 1 from our invalid coordinate to 
				  carry the diagonal through
				*/
				var yVariant:int = selectedPlayingPiece.direction == DraughtsPiece.DIRECTION_UP ? -1: 1;
				// hoppedCoord is the coord of the tile diagonally through the playing piece we are trying to hop over.
				var hoppedCoord:Array = [coord[0] + xVariant, coord[1] + yVariant];
				if(!isCoordinateOccupied(hoppedCoord, allActivePieces)) availableJumpedCoords.addItem(hoppedCoord); 
			}
			
			return availableJumpedCoords;
		}
		
		//Iterates through supplied playingPieces and checks their coordinates with the supplied coorindate param
		private function isCoordinateOccupied(coordinate:Array, playingPieces:ArrayCollection) : Boolean
		{
			var coordinateOccupied:Boolean;
			for each(var draughtsPiece:DraughtsPiece in playingPieces)
			{
				if(coordinate[0] == draughtsPiece.x && coordinate[1] == draughtsPiece.y)
				{
					coordinateOccupied = true;
					break;
				}
			}
			return coordinateOccupied;
		}
		
		private function get allActivePieces() : ArrayCollection
		{
			return new ArrayCollection(game.player1.activePieces.source.concat(game.player2.activePieces.source));
		}
		
		public function removeJumpedPiece(targetTile:Tile, selectedDraughtsPiece:DraughtsPiece) : void
		{
			var x:int = Math.max(targetTile.x, selectedDraughtsPiece.x) - 1;
			var y:int = Math.max(targetTile.y, selectedDraughtsPiece.y) - 1;
			
			var activePieces:ArrayCollection = game.activePlayer == game.player1 ? game.player2.activePieces : game.player1.activePieces;
			for each(var draughtsPiece:DraughtsPiece in activePieces)
			{
				if(draughtsPiece.x == x && draughtsPiece.y == y) 
				{
					activePieces.removeItemAt(activePieces.getItemIndex(draughtsPiece));
					break;
				}
			}
		}
		
	}
}
