package hatstand.models
{
	public class Game
	{
		private var _player1:Player;
		private var _player2:Player;
		
		public function Game()
		{
			_player1 = new Player(DraughtsPiece.DIRECTION_UP);
			_player2 = new Player(DraughtsPiece.DIRECTION_DOWN);
		}
		
		public function get player1() : Player { return _player1; }
		
		public function get player2() : Player { return _player2; }
	}
}