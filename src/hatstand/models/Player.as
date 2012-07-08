package hatstand.models
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;

	//TODO: Revalute DIRECTION stuff, dont like it
	
	public class Player extends EventDispatcher
	{
		private var _playingPieces:ArrayCollection;
		
		[Bindable]public var name:String; 
		
		public function Player(direction:int)
		{
			//Temporary naming
			var playerColour:String = direction == DraughtsPiece.DIRECTION_UP ? "Black" : "White";
			name = "Player (" + playerColour + ")"; 
			
			if(direction == DraughtsPiece.DIRECTION_UP) _playingPieces = generatePieces(direction, 5);
			if(direction == DraughtsPiece.DIRECTION_DOWN) _playingPieces = generatePieces(direction, 0);
			if(!_playingPieces) throw new Error("Error in creating playing pieces");
			
			activePieces.addEventListener(CollectionEvent.COLLECTION_CHANGE, onPlayingPiecesUpdated);
		}
		
		public function get playingPieces() : ArrayCollection { return _playingPieces; }
		
		public function get activePieces() : ArrayCollection
		{
			var pieces:ArrayCollection = new ArrayCollection();
			for each(var draughtsPiece:DraughtsPiece in playingPieces)
			{
				if(draughtsPiece.isActive) pieces.addItem(draughtsPiece);
			}
			return pieces;
		}
		
		private function generatePieces(direction:int, startYcoord:int) : ArrayCollection
		{
			var pieces:ArrayCollection = new ArrayCollection();
			
			//Currently hardcoded for 8x8 board
			for(var x:int = 0; x < 8; x++)
			{
				var y:int = startYcoord;
				while(y < startYcoord+3)
				{
					if((x%2 == 0 && y%2 == 0) || (x%2 > 0 && y%2 > 0)) pieces.addItem( new DraughtsPiece(direction, [x, y], this));
					y++;
				}
			}
			return pieces;
		}
		
		private function onPlayingPiecesUpdated(e:CollectionEvent) : void
		{
			trace("Number of pieces: " + activePieces.length);
			if(activePieces.length == 0) dispatchEvent(new Event("allPiecesCaptured"));
		}
	}
}