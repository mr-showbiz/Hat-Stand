package hatstand.models
{
	import mx.collections.ArrayCollection;

	public class GameBoard
	{
		private var _tiles:ArrayCollection;
		
		public function GameBoard(boardSize:int)
		{
			_tiles = createTiles(boardSize);
		}
		
		public function get tiles() : ArrayCollection
		{
			return _tiles;
		}
		
		[Bindable]
		public function set tiles(value:ArrayCollection) : void
		{
			_tiles = value;
		}
		
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
	}
}