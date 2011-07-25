package hatstand.views
{
	import hatstand.models.DraughtsPiece;
	import hatstand.models.GameBoard;
	import hatstand.models.Tile;
	
	import spark.components.Group;
	
	public class GameboardViewBase extends Group
	{
		private var _gameBoard:GameBoard;
		private var _selectedPlayingPiece:DraughtsPiece;
		private var _selectedTile:Tile;
		
		public function set selectedPlayingPiece(value:DraughtsPiece) : void
		{
			_selectedPlayingPiece = value;
		}

		[Bindable]
		public function get selectedPlayingPiece() : DraughtsPiece
		{
			return _selectedPlayingPiece;
		}
		
		public function set selectedTile(value:Tile) : void
		{
			_selectedTile = value;
			if(selectedTile && selectedPlayingPiece)
			{
				selectedPlayingPiece.position[0] = selectedTile.position.getItemAt(0);
				selectedPlayingPiece.position[1] = selectedTile.position.getItemAt(1);
			}
		
		}
		
		public function get selectedTile() : Tile { return _selectedTile; }
		
		[Bindable]
		public function set gameBoard(value:GameBoard) : void { _gameBoard = value; }
		public function get gameBoard() : GameBoard { return _gameBoard; }
	}
}