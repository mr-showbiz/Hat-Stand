package hatstand.models
{
	import mx.collections.ArrayCollection;

	public class Tile
	{
		private var _position:ArrayCollection;
		private var _showHighlight:Boolean;
		
		public function Tile(x:int, y:int)
		{
			_position = new ArrayCollection([x,y]);
		}
		
		public function get position() : ArrayCollection
		{
			return _position;
		}
		
		[Bindable]
		public function set showHighlight(value:Boolean) : void { _showHighlight = value; }
		public function get showHighlight() : Boolean { return _showHighlight; }
	}
}