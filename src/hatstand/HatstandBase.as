package hatstand 
{
	import hatstand.models.DraughtsPiece;
	import hatstand.models.Game;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexVersion;
	import mx.events.FlexEvent;
	import mx.graphics.IFill;
	import mx.graphics.SolidColor;
	
	import spark.components.Application;
	import spark.components.Group;
	import spark.primitives.Ellipse;
	
	public class HatstandBase extends Application
	{
		public var newGame:Game;
		public var gameBoard:Group;
		
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
			var pieceSize:int = 40;
			for each(var piece:DraughtsPiece in pieces)
			{
				var el:Ellipse = new Ellipse();
				el.fill = new SolidColor(color);
				el.width = pieceSize;
				el.height = pieceSize;
				el.x = piece.position[0] *pieceSize;
				el.y = piece.position[1] *pieceSize;
				
				gameBoard.addElement(el);
			}
		}

	}
}