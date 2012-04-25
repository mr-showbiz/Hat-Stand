package hatstand.models
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	public class Tile extends EventDispatcher
	{
		private var _showHighlight:Boolean;
		private var coords:Array;
		
		public function Tile(x:int, y:int)
		{
			coords = [x, y];
		}
		
		public function get x() : int
		{
			return coords[0];
		}
		
		public function get y() : int
		{
			return coords[1];
		}
		
		[Bindable]
		public function set showHighlight(value:Boolean) : void { _showHighlight = value; }
		public function get showHighlight() : Boolean { return _showHighlight; }
	}
}