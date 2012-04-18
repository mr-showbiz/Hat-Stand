package hatstand.models
{
	import mx.collections.ArrayCollection;

	public class Rules
	{
		private static var _instance:Rules;
		
		public function Rules()
		{
		}
		
		public static function getInstance() : Rules
		{
			return _instance ? _instance : _instance = new Rules();
		}
		
		public function validateMoves(draughtPiece:IDraughtsPiece) : ArrayCollection
		{
			return new ArrayCollection();
		}
		
		//Only go diagnal. 1 space in front
		private function rule1() : void
		{
			
		}
	}
}
