package hatstand.models
{
	import mx.collections.ArrayCollection;

	public class Tile
	{
		private var _position:ArrayCollection;
		
		public function Tile(x:int, y:int)
		{
			_position = new ArrayCollection([x,y]);
		}
		
		public function get position() : ArrayCollection
		{
			return _position;
		}
	}
}