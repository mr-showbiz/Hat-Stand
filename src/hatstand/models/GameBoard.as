package hatstand.models
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.core.INavigatorContent;

	/**
	 * Keeps track of the tiles
	 * 
	 * 1) onNewTurn: makes list of locked draughts pieces 
	 * 2) createTiles: creates tiles based on boardsize
	 * 3) Stores the selectedDraughtsPiece: SETTER if there are locked draughts pieces it shows the highlights
	 * 4) Stores the selectedTile: SETTER very bloated does TOO MUCH
	 * 5) highlightTiles: iterate through all Tiles, match with passed arraycollection
	 * 6) endOFTurnCleanup: 
	 *  
	 */
	
	public class GameBoard extends EventDispatcher
	{
		private var _tiles:ArrayCollection;
		private var _selectedDraughtsPiece:DraughtsPiece;
		private var _selectedTile:Tile;
		private var _size:int;
		private var _game:Game;
		
		private var lockedDraughtsPieces:ArrayCollection;
		
		private var validTiles:ArrayCollection = new ArrayCollection();
		
		public function GameBoard(boardSize:int, game:Game)
		{
			_size = boardSize;
			_tiles = createTiles();
			_game = game;
			
			lockedDraughtsPieces = new ArrayCollection();
			game.addEventListener("newTurn", onNewTurn);
		}
		
		private function get game() : Game { return _game; }
		
		public function get size() : int { return _size; }
		
		public function get tiles() : ArrayCollection { return _tiles; }
		[Bindable]
		public function set tiles(value:ArrayCollection) : void { _tiles = value; }
		
		private function get draughtsPieceTotalPerPlayer() : int
		{
			return _size * 1.5;
		}
		
		private function onNewTurn(e:Event) : void
		{
			for each(var draughtsPiece:DraughtsPiece in game.activePlayer.playingPieces)
			{
				if(Rules.getInstance().canCapturePiece(draughtsPiece).length) lockedDraughtsPieces.addItem(draughtsPiece); 
			}
		}
		
		private function createTiles() : ArrayCollection
		{
			var newTiles:ArrayCollection = new ArrayCollection();
			for (var y:int = 0; y < _size; y++)
			{
				for (var x:int = 0; x < _size; x++)
				{
					var tile:Tile = new Tile(x, y);
					newTiles.addItem(tile);
				}
			}
			return newTiles;
		}
		
		//Selected playing piece: by clicking on a playing piece
		[Bindable]
		public function get selectedDraughtsPiece() : DraughtsPiece { return _selectedDraughtsPiece; }
		public function set selectedDraughtsPiece(value:DraughtsPiece) : void 
		{ 
			if(lockedDraughtsPieces.length > 0 && !lockedDraughtsPieces.contains(value))
			{
				trace("Piece NOT valid.");
			}
			else
			{
				_selectedDraughtsPiece = value;
				
				validTiles.removeAll();
				
				var possibleMoves:ArrayCollection = Rules.getInstance().validateMoves(_selectedDraughtsPiece);
				
				highlightTiles(possibleMoves);
			}
			
		}

		//Selected tile: by clicking on a tile.
		
		public function get selectedTile() : Tile { return _selectedTile; }
		public function set selectedTile(value:Tile) : void
		{
			_selectedTile = value;
			
			if(selectedTile && selectedDraughtsPiece && validTiles.contains(_selectedTile))
			{
				var capturedDraughtsPiece:DraughtsPiece = moveDraughtsPiece();
				
				if(capturedDraughtsPiece)
				{
					capturedDraughtsPiece.isActive = false;
					var itemIndex:int = game.opponentPlayer.playingPieces.getItemIndex(capturedDraughtsPiece);
					if(itemIndex != -1) game.opponentPlayer.playingPieces.removeItemAt(itemIndex);

					//We need to check if we can jump again
					var chainedCoordinates:ArrayCollection = Rules.getInstance().canCapturePiece(); 
					if(chainedCoordinates.length > 0)
					{
						highlightTiles(chainedCoordinates);
						
						return;
					}
				}

				updateKingStatus();
					
				endOfTurnCleanUp();
			}
		}
		
		private function moveDraughtsPiece() : DraughtsPiece
		{
			var capturedDraughtsPiece:DraughtsPiece;
			
			if(isDraughtsPieceCaptured)
			{
				var x:int = Math.max(selectedTile.x, selectedDraughtsPiece.x) - 1;
				var y:int = Math.max(selectedTile.y, selectedDraughtsPiece.y) - 1;
				
				//Once removed from active pieces, we then need to remove the actual draughts piece from the view
				for each(var draughtsPiece:DraughtsPiece in game.opponentPlayer.playingPieces)
				{
					if(draughtsPiece.x == x && draughtsPiece.y == y) 
					{
						capturedDraughtsPiece = draughtsPiece;
						break;
					}
				}
			}
			
			selectedDraughtsPiece.coordinate = [selectedTile.x, selectedTile.y];
			
			return capturedDraughtsPiece;
		}
		
		private function updateKingStatus() : void
		{
			//Check if we've hit the top or bottom of the board
			//Check if we have enough pieces to make a king
			if(selectedDraughtsPiece.y == 0 || selectedDraughtsPiece.y == _size-1)
			{
				//Should be easier to get number of captured pieces
				var numberOfTakenPieces:int = draughtsPieceTotalPerPlayer - selectedDraughtsPiece.owner.playingPieces.length;
				var numberOfKings:int = 0;
				for each(var draughtsPiece:DraughtsPiece in selectedDraughtsPiece.owner.playingPieces)
				{
					if(draughtsPiece.isKing) numberOfKings++;
				}
				
				if(numberOfKings < numberOfTakenPieces) selectedDraughtsPiece.makeKing();
			}	
		}
		
		/*Logic here determines how far we've jumped (if greater than 1 tile in any direction we've jumped
		over a playing piece)*/
		private function get isDraughtsPieceCaptured() : Boolean
		{
			return (selectedTile.x - selectedDraughtsPiece.x) % 2 == 0;
		}
		
		//Change so this is somehow only accessible via debug options feature
		private function highlightTiles(tileCoordinates:ArrayCollection) : void
		{
			for each(var tile:Tile in tiles)
			{
				tile.showHighlight = false;
				for each(var coord:Array in tileCoordinates)
				{
					if(coord[0] == tile.x && coord[1] == tile.y)
					{
						tile.showHighlight = true;
						validTiles.addItem(tile);
					}
				}
			}
		}
		
		private function endOfTurnCleanUp() : void
		{
			lockedDraughtsPieces.removeAll();
			validTiles.removeAll();
			
			dispatchEvent(new Event("endOfTurn"));
		}
		
	}
}