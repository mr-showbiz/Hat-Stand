package hatstand.models
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	/**
	 * Keeps track of the tiles 
	 */
	
	public class GameBoard extends EventDispatcher
	{
		private var _tiles:ArrayCollection;
		private var _selectedDraughtsPiece:DraughtsPiece;
		private var _selectedTile:Tile;
		private var _boardSize:int;
		
		private var validTiles:ArrayCollection = new ArrayCollection();
		
		public function GameBoard(boardSize:int)
		{
			_boardSize = boardSize;
			_tiles = createTiles();
		}
		
		public function get tiles() : ArrayCollection { return _tiles; }
		[Bindable]
		public function set tiles(value:ArrayCollection) : void { _tiles = value; }
		
		private function createTiles() : ArrayCollection
		{
			var newTiles:ArrayCollection = new ArrayCollection();
			for (var y:int = 0; y < _boardSize; y++)
			{
				for (var x:int = 0; x < _boardSize; x++)
				{
					var tile:Tile = new Tile(x, y);
					newTiles.addItem(tile);
				}
			}
			return newTiles;
		}
		
		//Selected playing piece: by clicking on a playing piece
		[Bindable]
		public function get selectedDraughtsPiece() : DraughtsPiece { return _selectedDraughtsPiece; }
		public function set selectedDraughtsPiece(value:DraughtsPiece) : void 
		{ 
			_selectedDraughtsPiece = value;
			
			validTiles.removeAll();
			var possibleMoves:ArrayCollection = Rules.getInstance().validateMoves(_selectedDraughtsPiece);
			
			for each(var tile:Tile in tiles)
			{
				tile.showHighlight = false;
				for each(var coord:Array in possibleMoves)
				{
					if(coord[0] == tile.x && coord[1] == tile.y)
					{
						tile.showHighlight = true;
						validTiles.addItem(tile);
					}
				}
			}
		}

		//Selected tile: by clicking on a tile. 
		public function get selectedTile() : Tile { return _selectedTile; }
		public function set selectedTile(value:Tile) : void
		{
			_selectedTile = value;
			if(selectedTile && selectedDraughtsPiece && validTiles.contains(_selectedTile))
			{
				
				if((selectedTile.x - selectedDraughtsPiece.x) % 2 == 0)
				{
					Rules.getInstance().removeJumpedPiece(selectedTile, selectedDraughtsPiece);
					//We've just jumped.
					//We need to check if we can jump again
					Rules.getInstance().canJumpAgain();
				}
				
				selectedDraughtsPiece.coordinate = [selectedTile.x, selectedTile.y];
				
				//Check if we've hit the top or bottom of the board
				if(selectedDraughtsPiece.y == 0 || selectedDraughtsPiece.y == _boardSize-1) selectedDraughtsPiece.isKing = true;
				
				validTiles.removeAll();
				
				endOfTurnCleanUp();
			}
		}
		
		private function endOfTurnCleanUp() : void
		{
			dispatchEvent(new Event("endOfTurn"));
		}
		
	}
}