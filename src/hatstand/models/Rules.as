package hatstand.models
{
	import mx.collections.ArrayCollection;

	/**
	 * DOES THIS REALLY NEED TO BE A SINGLTON??!
	 * 
	 * Minimax decision theory
	 * 
	 * TODO:
	 * 1) perhaps change references to coordinates to actual tiles instead, so methods return tiles not coords
	 * 2) removeJumpedPiece: Is it the job of Rules to remove the pieces
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
		//TODO: Tidy this nasty collection of ifs (change DIRECTION stuff, I don't like it)
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
		
		/** Checks the space diagonally over from the invalid coord to see if it's free.
		   If it is, then we can potentially jump over the invalid coord's playing piece
		**/
		private function rule3(invalidCoords:ArrayCollection) : ArrayCollection
		{
			var availableJumpedCoords:ArrayCollection = new ArrayCollection();

			//Iterate through all invalid coords
			for each(var coord:Array in invalidCoords)
			{
				//Check if we are attempting to jump over our own pieces
				if(!isCoordinateOccupied(coord, selectedPlayingPiece.owner.playingPieces))
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
			return new ArrayCollection(game.player1.playingPieces.source.concat(game.player2.playingPieces.source));
		}
		
		// TODO: method name doesn't make sense with its return value
		public function canCapturePiece(draughtsPiece:DraughtsPiece = null) : ArrayCollection
		{
			if(draughtsPiece) selectedPlayingPiece = draughtsPiece;
			var chainedCoordinates:ArrayCollection = new ArrayCollection();
			for each(var coord:Array in rule1())
			{
				if(isJumpedCoordinate(coord))
				{
					chainedCoordinates.addItem(coord);
				}
			}
			
			return chainedCoordinates;
		}
		
		private function isJumpedCoordinate(coordinate:Array) : Boolean
		{
			return (selectedPlayingPiece.x - coordinate[0])%2 == 0;
		}
	}
}
