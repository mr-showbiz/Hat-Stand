package hatstand.views
{
	import hatstand.models.DraughtsPiece;
	
	import spark.components.Group;
	
	public class GameboardViewBase extends Group
	{
		private var _selectedPlayingPiece:DraughtsPiece;
		private var _selectedTile:GameboardTileItemRendererView;
		
		public function set selectedPlayingPiece(value:DraughtsPiece) : void
		{
			_selectedPlayingPiece = value;
		}

		[Bindable]
		public function get selectedPlayingPiece() : DraughtsPiece
		{
			return _selectedPlayingPiece;
		}
		
		public function set selectedTile(value:GameboardTileItemRendererView) : void
		{
			_selectedTile = value;
			if(selectedTile && selectedPlayingPiece)
			{
				selectedPlayingPiece.position[0] = selectedTile.x;
				selectedPlayingPiece.position[1] = selectedTile.y;
			}
		
		}
		
		public function get selectedTile() : GameboardTileItemRendererView
		{
			return _selectedTile;
		}
	}
}