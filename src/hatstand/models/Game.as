package hatstand.models
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	//Perhaps turn into singleton
	
	public class Game extends EventDispatcher
	{
		private var _player1:Player;
		private var _player2:Player;
		private var _gameBoard:GameBoard;
		
		[Bindable]public var activePlayer:Player;
		
		public function Game()
		{
			_player1 = new Player(DraughtsPiece.DIRECTION_DOWN);
			_player2 = new Player(DraughtsPiece.DIRECTION_UP);
			
			_player1.addEventListener("allPiecesCaptured", onAllPiecesCaptured);
			_player2.addEventListener("allPiecesCaptured", onAllPiecesCaptured);
			
			//TODO: Hardcoded game board size.
			_gameBoard = new GameBoard(8, this);
			
			_gameBoard.addEventListener("endOfTurn", onEndOfTurn);
			
			//Pass this new Game to Rules for later use
			Rules.getInstance().game = this;
			
			activePlayer = _player1;
		}
		
		public function get allDraughtsPieces() : ArrayCollection
		{
			return new ArrayCollection(player1.playingPieces.source.concat(player2.playingPieces.source));
		}
		
		public function get player1() : Player { return _player1; }
		
		public function get player2() : Player { return _player2; }
		
		public function get gameBoard() : GameBoard { return _gameBoard; }

		private function onEndOfTurn(e:Event) : void
		{
			activePlayer = activePlayer == _player1 ? _player2 : _player1;
			
			dispatchEvent(new Event("newTurn"));
		}
		
		private function onAllPiecesCaptured(e:Event) : void
		{
			dispatchEvent(new Event("gameOver"));
		}
		
	}
}