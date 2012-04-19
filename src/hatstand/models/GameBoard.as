package hatstand.models
{
	import mx.collections.ArrayCollection;

	/**
	 * Keeps track of the tiles 
	 */
	
	public class GameBoard
	{
		private var _tiles:ArrayCollection;
		private var _selectedPlayingPiece:DraughtsPiece;
		private var _selectedTile:Tile;
		
		public function GameBoard(boardSize:int)
		{
			_tiles = createTiles(boardSize);
		}
		
		public function get tiles() : ArrayCollection { return _tiles; }
		[Bindable]
		public function set tiles(value:ArrayCollection) : void { _tiles = value; }
		
		private function createTiles(boardSize:int) : ArrayCollection
		{
			var newTiles:ArrayCollection = new ArrayCollection();
			for (var y:int = 0; y < boardSize; y++)
			{
				for (var x:int = 0; x < boardSize; x++)
				{
					var tile:Tile = new Tile(x, y);
					newTiles.addItem(tile);
				}
			}
			return newTiles;
		}
		
		[Bindable]
		public function get selectedPlayingPiece() : DraughtsPiece { return _selectedPlayingPiece; }
		public function set selectedPlayingPiece(value:DraughtsPiece) : void 
		{ 
			_selectedPlayingPiece = value;
			var possibleMoves:ArrayCollection = Rules.getInstance().validateMoves(_selectedPlayingPiece);
			
			for each(var tile:Tile in tiles)
			{
				tile.showHighlight = false;
				for each(var coord:Array in possibleMoves)
				{
					if(coord[0] == tile.x && coord[1] == tile.y)
					{
						tile.showHighlight = true;
					}
				}
			}
		}
		
		public function set selectedTile(value:Tile) : void
		{
			_selectedTile = value;
			if(selectedTile && selectedPlayingPiece && selectedTile.showHighlight)
			{
				selectedPlayingPiece.coordinate = [selectedTile.x, selectedTile.y];
			}
		}
		
		public function get selectedTile() : Tile { return _selectedTile; }
	}
}