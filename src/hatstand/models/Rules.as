package hatstand.models
{
	import mx.collections.ArrayCollection;

	/**
	 * DOES THIS REALLY NEED TO BE A SINGLTON??!
	 * 
	 * 
	 * Minimax decision theory
	 * 
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
		//TODO: Tidy this nasty collection of ifs
		private function rule1() : ArrayCollection
		{
			var validCoords:ArrayCollection = new ArrayCollection();
			
			var xs:Array = [selectedPlayingPiece.x - 1, selectedPlayingPiece.x + 1];
			var ys:Array = [];
			if(selectedPlayingPiece.direction == DraughtsPiece.DIRECTION_UP)
			{
				ys.push(selectedPlayingPiece.y - 1);
			}
			else if(selectedPlayingPiece.direction == DraughtsPiece.DIRECTION_DOWN)
			{
				ys.push(selectedPlayingPiece.y + 1);
			}
			else if(selectedPlayingPiece.direction == DraughtsPiece.DIRECTION_ALL)
			{
				ys.push(selectedPlayingPiece.y + 1);
				ys.push(selectedPlayingPiece.y - 1);
			}
			
			for each(var y:int in ys)
			{
				for each(var x:int in xs)
				{
					validCoords.addItem([x, y]);	
				}
			}
			
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
			
			return rule3(inValidCoords).length > 0 ? rule3(inValidCoords) : coordinateList;
		}
		
		/* Checks the space diagonal over from the invalid coord to see if it's free.
		   If it is, then we can potentially jump over the invalid coord's playing piece
		*/
		private function rule3(invalidCoords:ArrayCollection) : ArrayCollection
		{
			var availableJumpedCoords:ArrayCollection = new ArrayCollection();

			//Iterate through all invalid coords
			for each(var coord:Array in invalidCoords)
			{
				//Check if we are attempting to jump over our own pieces
				if(!isCoordinateOccupied(coord, selectedPlayingPiece.owner.activePieces))
				{
					/* If the invalid coordinates x value minus our selected pieces x value is greater than 0 then we must
					plus 1 to the invalid coordinates x value to carry the diagonal through to the otherside.
					*/
					var xDelta:int = coord[0] - selectedPlayingPiece.x;
					/* If our selected piece is heading up the board, we need to minus 1 from our invalid coordinate to 
					carry the diagonal through */
					var yDelta:int = coord[1] - selectedPlayingPiece.y;
					// hoppedCoord is the coord of the tile diagonally through the playing piece we are trying to hop over.
					
					var newX:int = coord[0] + xDelta;
					var newY:int = coord[1] + yDelta;
					if(newX < 0 || newX > game.gameBoard.size - 1 || newY < 0 || newY > game.gameBoard.size -1) break;
					
					var hoppedCoord:Array = [coord[0] + xDelta, coord[1] + yDelta];
					if(!isCoordinateOccupied(hoppedCoord, allActivePieces)) availableJumpedCoords.addItem(hoppedCoord);	
				}
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
			
			//Once removed from active pieces, we then need to remove the actual draughts piece from the view
			var activePieces:ArrayCollection = game.activePlayer == game.player1 ? game.player2.activePieces : game.player1.activePieces;
			for each(var draughtsPiece:DraughtsPiece in activePieces)
			{
				if(draughtsPiece.x == x && draughtsPiece.y == y) 
				{
					
					draughtsPiece.isActive = false;
					break;
				}
			}
		}
		
		public function canJumpAgain() : void
		{
			
		}
		
	}
}
