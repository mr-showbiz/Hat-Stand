package hatstand 
{
	import flash.events.MouseEvent;
	
	import hatstand.models.DraughtsPiece;
	import hatstand.models.Game;
	import hatstand.views.GameBoardView;
	import hatstand.views.PlayingPiece;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import spark.components.Application;
	import spark.components.Group;
	
	public class HatstandBase extends Application
	{
		public var newGame:Game;
		public var playingPiecesContainer:Group;
		public var gameBoard:GameBoardView;
		
		public function HatstandBase()
		{
			super();
			 
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			newGame = new Game();
		}
		
		private function onCreationComplete(e:FlexEvent): void
		{
			positionPieces(newGame.player1.activePieces, 0xeeeeee);
			positionPieces(newGame.player2.activePieces, 0x333333);
		}
	
		private function positionPieces(pieces:ArrayCollection, color:uint) : void
		{
			for each(var piece:DraughtsPiece in pieces)
			{
				var playingPiece:PlayingPiece = new PlayingPiece();
				playingPiece.draughtsPiece = piece;
				playingPiece.playingPieceColor = color;
				playingPiece.addEventListener(MouseEvent.CLICK, function (e:MouseEvent) : void {
					gameBoard.selectedPlayingPiece = PlayingPiece(e.target).draughtsPiece;
				});

				playingPiecesContainer.addElement(playingPiece);
			}
		}

	}
}