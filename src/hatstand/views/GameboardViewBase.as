package hatstand.views
{
	import hatstand.models.DraughtsPiece;
	import hatstand.models.GameBoard;
	import hatstand.models.Tile;
	
	import spark.components.Group;
	
	public class GameboardViewBase extends Group
	{
		private var _gameBoard:GameBoard;
		
		[Bindable]
		public function set gameBoard(value:GameBoard) : void { _gameBoard = value; }
		public function get gameBoard() : GameBoard { return _gameBoard; }
	}
}