package hatstand.views
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import hatstand.models.DraughtsPiece;
	import hatstand.models.Game;
	
	import mx.events.FlexEvent;
	
	import spark.components.Group;
	
	public class GameViewBase extends Group
	{
		[Bindable] protected var game:Game;
		public var playingPiecesContainer:Group;
		public var gameBoardView:GameBoardView;
		
		public function GameViewBase()
		{
			game = new Game();
			game.addEventListener("gameOver", onGameOver);
			
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}	
	
		private function onCreationComplete(e:FlexEvent) : void
		{
			removeEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			positionPieces();
		}	
		
		//TODO: think of better way to assign colours to playingPiece
		private function positionPieces() : void
		{
			for each(var piece:DraughtsPiece in game.allDraughtsPieces)
			{
				var playingPiece:PlayingPiece = new PlayingPiece();
				playingPiece.draughtsPiece = piece;
				
				playingPiece.playingPieceColor = piece.owner == game.player1 ? 0xDDDDDD : 0x333333;
				
				//This isn't the place for this event to be dealt with
				playingPiece.addEventListener(MouseEvent.CLICK, function (e:MouseEvent) : void {
					if(game.activePlayer == PlayingPiece(e.target).draughtsPiece.owner) gameBoardView.gameBoard.selectedDraughtsPiece = PlayingPiece(e.target).draughtsPiece;
				});
				
				playingPiecesContainer.addElement(playingPiece);
			}
		}
		
		private function onGameOver(e:Event) : void
		{
			dispatchEvent(e);
			game.removeEventListener("gameOver", onGameOver);
		}
		
	}
}