package hatstand.models
{
	public class Game
	{
		private var _player1:Player;
		private var _player2:Player;
		private var _gameBoard:GameBoard;
		
		public function Game()
		{
			_player1 = new Player(DraughtsPiece.DIRECTION_UP);
			_player2 = new Player(DraughtsPiece.DIRECTION_DOWN);
			
			//TODO: Hardcoded game board size. Bad
			_gameBoard = new GameBoard(8);
		}
		
		public function get player1() : Player { return _player1; }
		
		public function get player2() : Player { return _player2; }
		
		public function get gameBoard() : GameBoard { return _gameBoard; } 
	}
}