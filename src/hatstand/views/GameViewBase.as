package hatstand.views
{
	import flash.events.MouseEvent;
	
	import hatstand.models.DraughtsPiece;
	import hatstand.models.Game;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import spark.components.Group;
	
	public class GameViewBase extends Group
	{
		[Bindable] public var game:Game;
		public var playingPiecesContainer:Group;
		public var gameBoardView:GameBoardView;
		
		public function GameViewBase()
		{
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}	
	
		private function onCreationComplete(e:FlexEvent) : void
		{
			positionPieces(game.player1.activePieces, 0x333333);
			positionPieces(game.player2.activePieces, 0xeeeeee);
		}	
		
		private function positionPieces(pieces:ArrayCollection, color:uint) : void
		{
			for each(var piece:DraughtsPiece in pieces)
			{
				var playingPiece:PlayingPiece = new PlayingPiece();
				playingPiece.draughtsPiece = piece;
				playingPiece.playingPieceColor = color;
				
				//This isn't the place for this event to be dealt with
				playingPiece.addEventListener(MouseEvent.CLICK, function (e:MouseEvent) : void {
					if(game.activePlayer == playingPiece.draughtsPiece.owner) gameBoardView.gameBoard.selectedDraughtsPiece = PlayingPiece(e.target).draughtsPiece;
				});
				
				playingPiecesContainer.addElement(playingPiece);
			}
		}
		
	}
}