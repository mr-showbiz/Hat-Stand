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
		private var _coords:Array;
		private var _owner:Player;
		private var _isActive:Boolean = true;
		private var _isKing:Boolean = false; 
		
		public function DraughtsPiece(direction:int, startingCoords:Array, owner:Player)
		{
			_direction = direction;
			_coords = startingCoords;
			_owner = owner;
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
			return _coords[0];
		}
		
		[Bindable(event="coordinatesUpdated")]
		public function get y() : int
		{
			return _coords[1];
		}
		
		public function set coordinate(coordinateArray:Array) : void
		{
			_coords = coordinateArray;
			
			dispatchEvent(new Event("coordinatesUpdated"));
		}
		
		public function get coordinate() : Array
		{
			return _coords;
		}
		
		public function get owner() : Player
		{
			return _owner;
		}
		
		public function set owner(value:Player) : void
		{
			_owner = value;
		}
		
		public function get isKing() : Boolean
		{
			return _isKing;
		}
			
		public function get isActive() : Boolean
		{
			return _isActive;
		}
		
		public function set isActive(value:Boolean) : void
		{
			_isActive = value;
			if(!isActive) dispatchEvent(new Event("draughtsPieceCaptured", true));
		}
		
		public function makeKing() : void
		{
			_isKing = true;
			direction = DIRECTION_ALL;
			
			dispatchEvent(new Event("onKinged"));
		}
		
	}
}