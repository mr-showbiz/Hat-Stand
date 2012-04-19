package hatstand.models
{
	import mx.collections.ArrayCollection;

	public class Rules
	{
		private static var _instance:Rules;
		
		private var selectedPlayingPiece:DraughtsPiece;
		
		public function Rules()
		{
		}
		
		public static function getInstance() : Rules
		{
			return _instance ? _instance : _instance = new Rules();
		}
		
		//TODO: Change so it's not an ArrayCollection of ArrayCollections, it's just silly
		public function validateMoves(draughtPiece:DraughtsPiece) : ArrayCollection
		{
			selectedPlayingPiece = draughtPiece;
			
			return rule1();
		}
		
		//Only go diagnal. 1 space in front
		private function rule1() : ArrayCollection
		{
			var validCoords:ArrayCollection = new ArrayCollection();
			
			var newY:int;
			if(selectedPlayingPiece.direction == DraughtsPiece.DIRECTION_UP)
			{
				newY = int(selectedPlayingPiece.y) + 1;
			}
			else
			{
				newY = int(selectedPlayingPiece.y) - 1;
			}
			
			var newX:int = int(selectedPlayingPiece.x) - 1;
			validCoords.addItem(new ArrayCollection([newX, newY]));
			
			var newX2:int = int(selectedPlayingPiece.x) + 1;
			validCoords.addItem(new ArrayCollection([newX2, newY]));
			
			return validCoords; 
		}
	}
}
