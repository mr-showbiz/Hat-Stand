package hatstand.models
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	[Event(name="coordinatesUpdated",type="flash.events.Event")]
	
	[Bindable]
	public class DraughtsPiece extends EventDispatcher implements IDraughtsPiece
	{
		public static const DIRECTION_UP:int = 0;
		public static const DIRECTION_DOWN:int = 1;
		public static const DIRECTION_ALL:int = 2;
		
		private var _direction:int;
		private var coords:Array;
		
		public function DraughtsPiece(direction:int, startingCoords:Array)
		{
			_direction = direction;
			coords = startingCoords;
		}
		
		public function get direction() : int
		{
			return _direction;
		}
			
		public function set direction(value:int) : void
		{
			_direction = value;
		}

		[Bindable(event="coordinatesUpdated")]
		public function get x() : int
		{
			return coords[0];
		}
		
		[Bindable(event="coordinatesUpdated")]
		public function get y() : int
		{
			return coords[1];
		}
		
		public function set coordinates(coordinateArray:Array) : void
		{
			coords = coordinateArray;
			
			dispatchEvent(new Event("coordinatesUpdated"));
		}
	}
}