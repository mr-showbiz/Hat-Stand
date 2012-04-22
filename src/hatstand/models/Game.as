package hatstand.models
{
	import flash.events.Event;

	public class Game
	{
		private var _player1:Player;
		private var _player2:Player;
		private var _gameBoard:GameBoard;
		
		[Bindable]public var activePlayer:Player;
		
		public function Game()
		{
			_player1 = new Player(DraughtsPiece.DIRECTION_UP);
			_player2 = new Player(DraughtsPiece.DIRECTION_DOWN);
			
			//TODO: Hardcoded game board size. Bad
			_gameBoard = new GameBoard(8);
			
			_gameBoard.addEventListener("endOfTurn", onEndOfTurn);
			
			//Pass this new Game to Rules for later use
			Rules.getInstance().game = this;
			
			activePlayer = _player1;
			
		}
		
		public function get player1() : Player { return _player1; }
		
		public function get player2() : Player { return _player2; }
		
		public function get gameBoard() : GameBoard { return _gameBoard; }
		
		private function onEndOfTurn(e:Event) : void
		{
			activePlayer = activePlayer == _player1 ? _player2 : _player1;
		}
		
	}
}