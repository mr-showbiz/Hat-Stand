package hatstand.models
{
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	public class DraughtsPiece implements IDraughtsPiece
	{
		public static const DIRECTION_UP:int = 0;
		public static const DIRECTION_DOWN:int = 1;
		public static const DIRECTION_ALL:int = 2;
		
		private var _direction:int;
		private var _position:Array;
		
		public function DraughtsPiece(direction:int, position:Array)
		{
			_direction = direction;
			_position = position;
		}
		
		public function get direction() : int
		{
			return _direction;
		}
			
		public function set direction(value:int) : void
		{
			_direction = value;
		}
		
		public function set position(value:Array) : void
		{
			_position = value; 
		}
		
		public function get position() : Array
		{
			return _position;
		}
	
	}
}